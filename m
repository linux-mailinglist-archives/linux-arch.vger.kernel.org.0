Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919996EBAC5
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDVR5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Apr 2023 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDVR5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Apr 2023 13:57:19 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92C1FF6;
        Sat, 22 Apr 2023 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1682186234; bh=Av45NfRoNWrmwrDlg/7iwNEk5cNcTXe/Apg381TE9cc=;
        h=From:To:Cc:Subject:Date:From;
        b=Fz3ZgnjO3hS4PjxTm80vD2yKCWd/OhZHTccXsoeXvyYk49q27YYpqPCX6h087K4Ux
         bj4CNpZBPvl4ssChpsidAIzxGTTVBAja4Scox2QrJ3FK1GEgM8Yrpd/OIS9fxYINAn
         b/P1BkV3UjmEJX0MZvlAuB/z7DMNCX704gJA+2NA=
Received: from ld50.lan (unknown [101.228.138.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0F92F600BD;
        Sun, 23 Apr 2023 01:57:13 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] LoongArch: Make bounds-checking instructions useful
Date:   Sun, 23 Apr 2023 01:57:03 +0800
Message-Id: <20230422175705.3444561-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Hi,

The LoongArch-64 base architecture is capable of performing
bounds-checking either before memory accesses or alone, with specialized
instructions generating BCEs (bounds-checking error) in case of failed
assertions (ISA manual Volume 1, Sections 2.2.6.1 [1] and 2.2.10.3 [2]).
This could be useful for managed runtimes, but the exception is not
being handled so far, resulting in SIGSYSes in these cases, which is
incorrect and warrants a fix in itself.

During experimentation, it was discovered that there is already UAPI for
expressing such semantics: SIGSEGV with si_code=SEGV_BNDERR. This was
originally added for Intel MPX, and there is currently no user (!) after
the removal of MPX support a few years ago. Although the semantics is
not a 1:1 match to that of LoongArch, still it is better than
alternatives such as SIGTRAP or SIGBUS of BUS_OBJERR kind, due to being
able to convey both the value that failed assertion and the bound value.

This patch series implements just this approach: translating BCEs into
SIGSEGVs with si_code=SEGV_BNDERR, si_value set to the offending value,
and si_lower and si_upper set to resemble a range with both lower and
upper bound while in fact there is only one.

The instructions are not currently used anywhere yet in the fledgling
LoongArch ecosystem, so it's not very urgent and we could take the time
to figure out the best way forward (should SEGV_BNDERR turn out not
suitable).

[1]: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#bound-check-memory-access-instructions
[2]: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_asrtlegt_d

Changes since v1:

- rebased on top of current loongarch-next
- removed code related to the kprobe notifier mechanism

WANG Xuerui (2):
  LoongArch: Add opcodes of bounds-checking instructions
  LoongArch: Relay BCE exceptions to userland as SIGSEGVs with
    si_code=SEGV_BNDERR

 arch/loongarch/include/asm/inst.h | 26 ++++++++
 arch/loongarch/kernel/genex.S     |  1 +
 arch/loongarch/kernel/traps.c     | 99 +++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

-- 
2.40.0


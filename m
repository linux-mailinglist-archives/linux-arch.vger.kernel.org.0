Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12F516507
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbiEAPzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348466AbiEAPxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 11:53:51 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 May 2022 08:50:24 PDT
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182CA19A;
        Sun,  1 May 2022 08:50:22 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 9C72666572;
        Sun,  1 May 2022 11:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1651419819;
        bh=zOPsBSx7MiUB+ZqOHghOHm8qfFVAtKp41vweKTfuR9Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=chiIDiWrfvBANVYZcx5ch8dWm3tUnKxIxSJBshjwu+lkytEbScppy8Ts5LkacqzHN
         X6jKxFVvtcULpdAwTLUdf1xgdLVduqdKmC7D5hi0JejbNByhH+VWg9/FtPtrFnh0JF
         mtTcTj+hfSvwOJjDkyzAsbe2HLsE7Ffg7862F5qOfrZ7LtUWK+lby+DTxd82t26+Nx
         ScQXWJ6gAbBIS52lH1eZZFzwONlmAZzV01Cl0CsSX4znhCkcqs/SDLBp62vPD3XG9t
         LVA6AXluwAhP5cbQPWxkreFRRUnecpSmlHjYhDfC42oV7YSInIfPLR737G9oL+KAyb
         /ZQFXthlDLpGA==
Message-ID: <0f42779799d54d2478a644391096c2d85e494c49.camel@mengyan1223.wang>
Subject: Re: [PATCH V9 05/24] LoongArch: Add build infrastructure
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 01 May 2022 23:43:32 +0800
In-Reply-To: <3f46aa25-ef45-fff8-dba5-5db1034b38d9@xen0n.name>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
         <20220430090518.3127980-6-chenhuacai@loongson.cn>
         <3f46aa25-ef45-fff8-dba5-5db1034b38d9@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2022-05-01 at 18:09 +0800, WANG Xuerui wrote:
> > +cflags-y +=3D $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
> Unfortunately we're still working around the LL/SC hardware issue even
> after migrating to LoongArch... might be better to add a comment too.=20
> (something along the line of "we work around the issue manually in the
> handwritten assembly, so no automatic workarounds should kick in")

There is no LoongArch assembler which is publicly available and has a -
m(no)?fix-loongson3-llsc option.  The people writing assembly have to
add the workarounds manually.

This line should be removed for a upstream patch.  If you need to
support "unpublic" toolchains with this option, keep it in a seperate
git repo or branch.

Regarding LL/SC workaround, GCC is using a different pattern:

(https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob;f=3Dgcc/config/loongarch/syn=
c.md;h=3D0c4f1983;hb=3DHEAD#l132)

 132   return "%G5\\n\\t"
 133          "1:\\n\\t"
 134          "ll.<amo>\\t%0,%1\\n\\t"
 135          "bne\\t%0,%z2,2f\\n\\t"
 136          "or%i3\\t%6,$zero,%3\\n\\t"
 137          "sc.<amo>\\t%6,%1\\n\\t"
 138          "beq\\t$zero,%6,1b\\n\\t"
 139          "b\\t3f\\n\\t"
 140          "2:\\n\\t"
 141          "dbar\\t0x700\\n\\t"
 142          "3:\\n\\t";

Note that the dbar instruction has "hint" 0x700 instead of 0 (using a
special number was proposed by me, so an updated LoongArch
implementation can recognize and ignore this instruction when the
workaround is unneeded).  And the instruction is "skipped" by the
previous "b" instruction.  I guess it's enough to "force" LA464 to
behave correctly for the LL/SC loop w/o really inserting a barrier.

GCC LoongArch port maintainers have not publicly explained the rational
of this pattern, but it works fine in userspace on a 3A5000 processor.=20
Maybe the kernel could also benefit from this "new" pattern but I'm not
sure.  I suggest to discuss this with your compiler team and hardware
team.
--=20
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

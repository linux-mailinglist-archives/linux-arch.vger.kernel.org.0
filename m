Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2B53C795
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiFCJcW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFCJcW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 05:32:22 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C42B24E;
        Fri,  3 Jun 2022 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1654248735;
        bh=L6vnBNt1rIQ4ybJ0twJCwhIdxM9LDIUngFwqwnJ0+zg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aA2vWSFARgbtMA6PZNK7yh2b1C4zoBwskJLD2/d8KUfXCx12jeBrzWeqzj6H1QyGO
         G+1eHFUDZyexjmiak1ycPPoPa2ea61VluhH2k3Q8h2932b5iRxb2SQ9dBxaWzZ4nDc
         LSpQ0WJnC00vkQ3vwhcvcnT1do1scpA4n6VCtumQ=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E7EFD66830;
        Fri,  3 Jun 2022 05:32:09 -0400 (EDT)
Message-ID: <dab96b787bef91240c719ea1a100396350135f99.camel@xry111.site>
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi@vger.kernel.org, WANG Xuerui <git@xen0n.name>,
        Yun Liu <liuyun@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 03 Jun 2022 17:32:07 +0800
In-Reply-To: <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
         <20220602115141.3962749-12-chenhuacai@loongson.cn>
         <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2022-06-02 at 22:09 +0800, WANG Xuerui wrote:

> For this, I don't know if Huacai should really just leave those=20
> modification in the downstream fork to keep the upstream Linux clean of=
=20
> such hacks, because to some degree dealing with such notoriety is life,=
=20
> it seems to me. I think at this point Huacai would cooperate and tweak
> the patch to get rid of the SVAM and other nonstandard bits as much as
> possible, and I'll help him where necessary too.

To me any new firmware for PC-like platforms should implement UEFI.  For
embedded platforms device tree support will be added later.

For those guys impossible or unwilling to upgrade the firmware, it may
be possible to implement a compatibility layer and the booting procedure
will be like:

old firmware -> bootloongarch.efi -> customized u-boot -> bootloongarch64.e=
fi (grub) -> efi stub (kernel)
                --------- compatibility layer --------    ^^^^^^^^ normal U=
EFI compatible stuff ^^^^^^^^^

new firmware -> bootloongarch64.efi (grub) -> efi stub (kernel)

The old firmware route would be similar to the booting procedure of
Asahi Linux.  I think this can be implemented because it's already
implemented on M1 even while Apple is almost completely uncooperative.

Just my 2 cents. I know almost nothing about booting.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

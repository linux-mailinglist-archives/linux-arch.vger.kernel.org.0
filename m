Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC26A2F0C
	for <lists+linux-arch@lfdr.de>; Sun, 26 Feb 2023 11:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBZKNg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Feb 2023 05:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZKNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Feb 2023 05:13:36 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166CD315;
        Sun, 26 Feb 2023 02:13:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B11735C00C3;
        Sun, 26 Feb 2023 05:13:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 26 Feb 2023 05:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677406411; x=1677492811; bh=l4r/xag3fP
        iBIa7AoulX8EdHZShxnE+pA73Y6qWVSEY=; b=nOTnHLqj9YttJI8fGL7WALpUpj
        4ELRxvFFI8Z7K2APjEu/Qx/cyjhnLKMZreunCQXb5JUE5FBBPp5w9n9LfxPYHbHI
        4GCNFiWf4tqsuYqvXoViguwM+Q+sEVB2Fcu3dUJLKNg0uPZ/j8asch8gbtT52cjr
        cltviyJbOlZzacFRP/8i8TwEUDgGCczR9DYxGLs1044rvh097QeKykKDvhZPb+eA
        cFq2itmLIqIThYn+OJQceCWSC32h03jw4D3KNKKePFoOPM5txEWr7yDK92mapJaI
        XhN1jZ+XA3vmEMR78aacoB1H+bAaAZ+XTe/GkaEYd7GWW9UL7bOIgiJzla4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677406411; x=1677492811; bh=l4r/xag3fPiBIa7AoulX8EdHZShx
        nE+pA73Y6qWVSEY=; b=M0Q1n7p4AaMHdV3UNTytWG8R5WT3WdTny5jyhiU3KOBf
        VpEmwrSVGnzllmR00FUaUIkcieW30clMHc03LeX5ATfNFhDg058WS8kZuBDqg48H
        Kqi5Hdpxhz3wmM+S/gwx2WLCTriY8ivlsvxO1bRzBcuJgD0VBfZAJuDXGe+dAkft
        D7zYIOOV61zNheAN8NpIcgA7ztslCFgqFZKKHRd3sxlDuAr3ev+0dablLxqjbBnn
        fa+A4bf0t4bpCQTKr3Q1gjPnONWMq8i0HY7eTXM+dTAN7pBpQrS6PiMTy44KxZ0p
        JewSgQZWVoR2RkI31Ed2QhNSjMU1RTQm8OYsrsbSZg==
X-ME-Sender: <xms:yzD7Y9KoqWEXdfzWRqTcn1fS4GqqLkwRDIJaXPKojlg31g4FndnPvA>
    <xme:yzD7Y5Kpdwjevnqjd9AESgCQJZgZk6fl__jgWxV6_c0siS-eIU-FgFdn4I_YLf-5H
    vGRFq8PE6UG1k45xxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekjedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yzD7Y1u3RAPn4wV6irKf3R6E95wWsMJfUfHADLrtvBWN-qejwdW-lg>
    <xmx:yzD7Y-Y_xVd61_BWCIy9dOqQ2RCUL7ZIrBXEfZqCMSoDZ_W-a8G1Zg>
    <xmx:yzD7Y0adsC63qIxqO6a38Pa9-YX1j-53fS0bzzXcZaAJlOpVFGvVNQ>
    <xmx:yzD7Y_whsgQlL6NFNyDHuD2GOwUeI11fpXOsb-3nkTC6ZobTozwJJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 31714B60086; Sun, 26 Feb 2023 05:13:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <e27d184e-2561-4efe-a191-8c0401f815b0@app.fastmail.com>
In-Reply-To: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
References: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
Date:   Sun, 26 Feb 2023 11:13:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Matt Evans" <mev@rivosinc.com>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH] locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare
 against zero-extended 'old' value
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 1, 2023, at 19:39, Matt Evans wrote:
> __generic_cmpxchg_local takes unsigned long old/new arguments which
> might end up being up-cast from smaller signed types (which will
> sign-extend).  The loaded compare value must be compared against a
> truncated smaller type, so down-cast appropriately for each size.
>
> The issue is apparent on 64-bit machines with code, such as
> atomic_dec_unless_positive(), that sign-extends from int.
>
> 64-bit machines generally don't use the generic cmpxchg but
> development/early ports might make use of it, so make it correct.
>
> Signed-off-by: Matt Evans <mev@rivosinc.com>

Hi Matt,

I'm getting emails about nios2 sparse warnings from the
kernel test robot about your patch. I can also reproduce
this on armv5:


fs/erofs/zdata.c: note: in included file (through /home/arnd/arm-soc/arch/arm/include/asm/cmpxchg.h, /home/arnd/arm-soc/arch/arm/include/asm/atomic.h, /home/arnd/arm-soc/include/linux/atomic.h, ...):
include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates bits from constant value (5f0ecafe becomes fe)
include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates bits from constant value (5f0ecafe becomes cafe)
include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates bits from constant value (5f0ecafe becomes fe)
include/asm-generic/cmpxchg-local.h:30:42: warning: cast truncates bits from constant value (5f0edead becomes ad)
include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates bits from constant value (5f0ecafe becomes cafe)
include/asm-generic/cmpxchg-local.h:34:44: warning: cast truncates bits from constant value (5f0edead becomes dead)

This was already warning for the 'new' cast, but now also warns
for the 'old' cast, so the bot thinks this is a new problem.

I managed to shut up the warning by using a binary '&' operator
instead of the cast, but I wonder if it would be better to do
also mask this in the caller, when arch_atomic_cmpxchg() with its
signed argument calls into arch_cmpxchg() with its unsigned argument:

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 04b8be9f1a77..e271d6708c87 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -130,7 +130,7 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_read(v)                    READ_ONCE((v)->counter)
 #define arch_atomic_set(v, i)                  WRITE_ONCE(((v)->counter), (i))
 
-#define arch_atomic_xchg(ptr, v)               (arch_xchg(&(ptr)->counter, (v)))
-#define arch_atomic_cmpxchg(v, old, new)       (arch_cmpxchg(&((v)->counter), (old), (new)))
+#define arch_atomic_xchg(ptr, v)               (arch_xchg(&(ptr)->counter, (u32)(v)))
+#define arch_atomic_cmpxchg(v, old, new)       (arch_cmpxchg(&((v)->counter), (u32)(old), (u32)(new)))
 
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index c3e7315b7c1d..f9d52d1f0472 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -26,20 +26,20 @@ static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
        raw_local_irq_save(flags);
        switch (size) {
        case 1: prev = *(u8 *)ptr;
-               if (prev == (u8)old)
-                       *(u8 *)ptr = (u8)new;
+               if (prev == (old & 0xff))
+                       *(u8 *)ptr = (new & 0xffu);
                break;
        case 2: prev = *(u16 *)ptr;
-               if (prev == (u16)old)
-                       *(u16 *)ptr = (u16)new;
+               if (prev == (old & 0xffffu))
+                       *(u16 *)ptr = (new & 0xffffu);
                break;
        case 4: prev = *(u32 *)ptr;
-               if (prev == (u32)old)
-                       *(u32 *)ptr = (u32)new;
+               if (prev == (old & 0xffffffffu))
+                       *(u32 *)ptr = (new & 0xffffffffu);
                break;
        case 8: prev = *(u64 *)ptr;
                if (prev == old)
-                       *(u64 *)ptr = (u64)new;
+                       *(u64 *)ptr = new;
                break;
        default:
                wrong_size_cmpxchg(ptr);


     Arnd

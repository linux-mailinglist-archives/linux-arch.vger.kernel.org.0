Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616D7534814
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiEZB1E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbiEZB07 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 21:26:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F389D4E2
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 18:26:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p8so462380pfh.8
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 18:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IJTqDFjqCzxzT9sNGwb8smwhndUIJK3si2+NAvjLPes=;
        b=Fo56R9QSrSXqfV05MSzzv7c9rMI/iX8H4AGbweLENhxpW5nawqk8y+LqBTCmNg/4i+
         PhXsfFO5c2nBs6fmgjNmwkm+l+iPglwQplWAFk31l2ERXQSR+O8CS83VxWDKHreBauXZ
         C+tIF31wEw/+dWjT+ZrNsjeJafF81tZHuvLMYl2o87d8VzeDw/ei3kuAdkSOYZY6szYf
         /cpcSCkjZrMPdcHw8DAxQ8TdyoZqFlv155nOz1bEHxRW2aRtYt4OLf9v5ZlVNxGt8FTQ
         Ad3jAt5arJXGF/YwYauIPTunz82O+JznzJ+J9Gg2wxJBWktLH8WUbpNHfUT5nZDvCh0n
         B5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IJTqDFjqCzxzT9sNGwb8smwhndUIJK3si2+NAvjLPes=;
        b=4R2nnD5JcaFKQ8UOVwgOaLXZV2DijTeExhX6+GimZWyfwBG8bzPzjX8fxB6DdS9d10
         kH7y446cNBFfhr+Ef3vl0U+BMB7LqblPoPUBISt1DeIQ8XKyIYs94c3qE7Enq2XXmGt/
         4GmcXcwCPQLWINDlam/iBkzXwvWYZe+QZAO/3/G+khpSSRnyUQ/Qd/fC8+3l2kivSi0F
         /8/ldSx144u4tH7QbLwbttju5idVhbRT2psx23zdHtjRa8MXJik6NU2KIqBlEnoIxj1F
         3kF8+owyP9LqxPaAwS+PqC6zBJFF9RS5W1OM62Tcb1S8s54pvAqsQToocITD/jdtbEjB
         mxYw==
X-Gm-Message-State: AOAM5313k0/CGVK6b+kZhRkbbxfWjHNsKVlUY/YmWjJ0fv1oswURpHWK
        JxJ5J6QM0vVf8jXl6qIxzK1ONg==
X-Google-Smtp-Source: ABdhPJwxw+ZGBVWh2A3SVMACHEfgZ3hR+byOfKJRugCCmYszTXdAzNBFX/0zwN8agIEbo1Dw5NMdUw==
X-Received: by 2002:a65:6cc3:0:b0:3f6:26e9:5c1 with SMTP id g3-20020a656cc3000000b003f626e905c1mr30607276pgw.28.1653528416310;
        Wed, 25 May 2022 18:26:56 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709028bc500b001608bceb092sm51637plo.124.2022.05.25.18.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:26:55 -0700 (PDT)
Date:   Wed, 25 May 2022 18:26:55 -0700 (PDT)
X-Google-Original-Date: Wed, 25 May 2022 18:26:54 PDT (-0700)
Subject:     Re: [PATCH V2] riscv: compat: Using seperated vdso_maps for compat_vdso_info
In-Reply-To: <CAJF2gTQvmKE5UYTmhQMd0MTF-CJm08_VHpcSqS7ik=MGtZ0Jag@mail.gmail.com>
CC:     jrtc27@jrtc27.com, Arnd Bergmann <arnd@arndb.de>,
        linux@roeck-us.net, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-33d1c05c-e54e-4b8d-a016-18560b855e33@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 25 May 2022 18:24:01 PDT (-0700), guoren@kernel.org wrote:
> On Thu, May 26, 2022 at 9:00 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>
>> On 26 May 2022, at 01:33, guoren@kernel.org wrote:
>> >
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > This is a fixup for vdso implementation which caused musl to
>> > fail.
>> >
>> > [   11.600082] Run /sbin/init as init process
>> > [   11.628561] init[1]: unhandled signal 11 code 0x1 at
>> > 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>> > [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
>> > 5.18.0-rc7-next-20220520 #1
>> > [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>> > [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
>> > 00ffffffc58199f0
>> > [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
>> > ffffffffffffffff
>> > [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
>> > 00ffffff8ade0cc0
>> > [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
>> > 00ffffffc5819a00
>> > [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
>> > 00ffffffc5819b00
>> > [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
>> > 0000000000000000
>> > [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
>> > 00ffffff8ade0728
>> > [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
>> > 00ffffffc5819e40
>> > [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
>> > 0000000000000000
>> > [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
>> > 0000000000000001
>> > [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>> > [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
>> > cause: 000000000000000d
>> >
>> > The last __vdso_init(&compat_vdso_info) replaces the data in normal
>> > vdso_info. This is an obvious bug.
>> >
>> > Reported-by: Guenter Roeck <linux@roeck-us.net>
>> > Tested-by: Guenter Roeck <linux@roeck-us.net>
>> > Tested-by: Heiko Stübner <heiko@sntech.de>
>> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > Signed-off-by: Guo Ren <guoren@kernel.org>
>> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> > ---
>> > Changes in V2:
>> > - Add Tested-by
>> > - Rename vvar & vdso in /proc/<pid>/maps.
>>
>> Why? No other architecture renames it to that, and various pieces of
>> software look for the magic [vdso] name, including GDB and LLDB, though
>> by my count there are 57 source packages in Debian that contain the
>> string literal "[vdso]" (including quotes), including Firefox,
>> Android's ART, lvm2 and elfutils.
> Opps, Thx for pointing this out. Abandon the version of the patch. @Palmer

OK, I'll stick with the v1 I had -- everything was still in staging 
anyway, though the tests probably wouldn't have found this one as I 
don't run any of those (I'm just running buildroot's defaults).

>
>>
>> Jess
>>
>> > ---
>> > arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>> > 1 file changed, 13 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>> > index 50fe4c877603..957f164c9778 100644
>> > --- a/arch/riscv/kernel/vdso.c
>> > +++ b/arch/riscv/kernel/vdso.c
>> > @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>> > };
>> >
>> > #ifdef CONFIG_COMPAT
>> > +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
>> > +     [RV_VDSO_MAP_VVAR] = {
>> > +             .name   = "[compat vvar]",
>> > +             .fault = vvar_fault,
>> > +     },
>> > +     [RV_VDSO_MAP_VDSO] = {
>> > +             .name   = "[compat vdso]",
>> > +             .mremap = vdso_mremap,
>> > +     },
>> > +};
>> > +
>> > static struct __vdso_info compat_vdso_info __ro_after_init = {
>> >       .name = "compat_vdso",
>> >       .vdso_code_start = compat_vdso_start,
>> >       .vdso_code_end = compat_vdso_end,
>> > -     .dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
>> > -     .cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
>> > +     .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
>> > +     .cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>> > };
>> > #endif
>> >
>> > --
>> > 2.36.1
>> >
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>
>
> -- 
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B153447C
	for <lists+linux-arch@lfdr.de>; Wed, 25 May 2022 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiEYTqE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 25 May 2022 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiEYTqB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 15:46:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87C3615A;
        Wed, 25 May 2022 12:45:58 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ntwx4-0007tM-W8; Wed, 25 May 2022 21:45:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: compat: Using seperated vdso_maps for compat_vdso_info
Date:   Wed, 25 May 2022 21:45:50 +0200
Message-ID: <4595022.rnE6jSC6OK@diego>
In-Reply-To: <2757790.88bMQJbFj6@diego>
References: <20220525160404.2930984-1-guoren@kernel.org> <2757790.88bMQJbFj6@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Mittwoch, 25. Mai 2022, 21:36:16 CEST schrieb Heiko Stübner:
> Am Mittwoch, 25. Mai 2022, 18:04:04 CEST schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > This is a fixup for vdso implementation which caused musl to
> > fail.
> > 
> > [   11.600082] Run /sbin/init as init process
> > [   11.628561] init[1]: unhandled signal 11 code 0x1 at
> > 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> > [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
> > 5.18.0-rc7-next-20220520 #1
> > [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> > [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
> > 00ffffffc58199f0
> > [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
> > ffffffffffffffff
> > [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
> > 00ffffff8ade0cc0
> > [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
> > 00ffffffc5819a00
> > [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
> > 00ffffffc5819b00
> > [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
> > 0000000000000000
> > [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
> > 00ffffff8ade0728
> > [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
> > 00ffffffc5819e40
> > [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
> > 0000000000000000
> > [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
> > 0000000000000001
> > [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> > [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
> > cause: 000000000000000d
> > 
> > The last __vdso_init(&compat_vdso_info) replaces the data in normal
> > vdso_info. This is an obvious bug.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Heiko Stübner <heiko@sntech.de>
> 
> on palmer's for-next branch and a Debian riscv64 rootfs:
> 
> - WITHOUT this patch I end up with:
> [    3.142030] Unable to handle kernel paging request at virtual address ff60007265776f78
> [    3.144398] Oops [#1]
> [    3.144882] Modules linked in:
> [    3.145620] CPU: 1 PID: 1 Comm: init Not tainted 5.18.0-rc1-00049-g8810d7feee5a #225
> [    3.146698] Hardware name: riscv-virtio,qemu (DT)
> [    3.147441] epc : special_mapping_fault+0x4c/0x8e
> [    3.148352]  ra : __do_fault+0x28/0x11c
> [    3.149005] epc : ffffffff8011ce3e ra : ffffffff80113216 sp : ff2000000060bd20
> [    3.149851]  gp : ffffffff810de540 tp : ff600000012a8000 t0 : ffffffff80008af0
> [    3.150651]  t1 : ffffffff80c001e0 t2 : ffffffff80c00260 s0 : ff2000000060bd30
> [    3.151434]  s1 : ff2000000060bd78 a0 : ff600000013165f0 a1 : ff60000001dbc450
> [    3.152734]  a2 : ff2000000060bd78 a3 : 00fffffffffff000 a4 : ff6000003f0337c8
> [    3.153821]  a5 : ff60007265776f70 a6 : 0000000000000000 a7 : 0000000000000007
> [    3.154709]  s2 : ff60000001dbc450 s3 : ff60000001dbc450 s4 : ffffffff810ddd69
> [    3.155557]  s5 : ff60000001dbc450 s6 : 0000000000000254 s7 : 000000000000000c
> [    3.156369]  s8 : 000000000000000f s9 : 000000000000000d s10: ff60000001cf8080
> [    3.157242]  s11: 000000000000000d t3 : 00ffffff8232d000 t4 : 000000006ffffdff
> [    3.158094]  t5 : 000000006ffffe35 t6 : 000000000000000a
> [    3.158742] status: 0000000200000120 badaddr: ff60007265776f78 cause: 000000000000000d
> [    3.160000] [<ffffffff80113216>] __do_fault+0x28/0x11c
> [    3.160881] [<ffffffff80116f3e>] __handle_mm_fault+0x6ec/0x9c8
> [    3.161619] [<ffffffff8011729c>] handle_mm_fault+0x82/0x136
> [    3.162308] [<ffffffff80008c10>] do_page_fault+0x120/0x31c
> [    3.163006] [<ffffffff800032dc>] ret_from_exception+0x0/0xc
> [    3.164607] ---[ end trace 0000000000000000 ]---
> -> a different error
> 
> 
> - WITH this patch applied on top, the error above goes away and the
>   qemu-system can boot normally.

The linux-next tree that failed for me yesterday, also works again
after this patch is applied.

Heiko


> So, while my error is different and I don't think there is any musl in
> my rootfs, this patch definitly fixes the issue for me, so
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> 
> > ---
> >  arch/riscv/kernel/vdso.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > index 50fe4c877603..69b05b6c181b 100644
> > --- a/arch/riscv/kernel/vdso.c
> > +++ b/arch/riscv/kernel/vdso.c
> > @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
> >  };
> >  
> >  #ifdef CONFIG_COMPAT
> > +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
> > +	[RV_VDSO_MAP_VVAR] = {
> > +		.name   = "[vvar]",
> > +		.fault = vvar_fault,
> > +	},
> > +	[RV_VDSO_MAP_VDSO] = {
> > +		.name   = "[vdso]",
> > +		.mremap = vdso_mremap,
> > +	},
> > +};
> > +
> >  static struct __vdso_info compat_vdso_info __ro_after_init = {
> >  	.name = "compat_vdso",
> >  	.vdso_code_start = compat_vdso_start,
> >  	.vdso_code_end = compat_vdso_end,
> > -	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> > -	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> > +	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> > +	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> >  };
> >  #endif
> >  
> > 
> 
> 





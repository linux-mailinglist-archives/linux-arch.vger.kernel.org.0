Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21E3692209
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjBJPXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 10:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjBJPXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 10:23:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5192CFC1;
        Fri, 10 Feb 2023 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676042611; x=1707578611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Pkhd7L0Rr6+g1/WEDjw/dHyNxQqeeIwIMB2XHYXKnw=;
  b=QEHH4nNF/g5izVs+HTrPWq7mQzr46GqaZ0S7iWuJIz6sb1sGOxiNiIGm
   nXTlLuF1oLk/wz6Nbg8MuH21RCCpqLZoDhAF/Cocuykctbv+hw9/wD86b
   jLjqJFifV50Ame2aY0kgIvrMmQ/eJ6ECCK0ci016suxeqnV8X5EsGgtjS
   3SfuuhGP1YtU+jneavBYcgAMQXQtVEmRYX4554MTztR6kr7g2VvKXa28t
   M31ScJSwebedaGvvc6FiS2zRf+JwmcJrmmGBasY3w0yokM+hDYDKHDa6y
   4GMGRINGqDIWAGrlQ6iQX27AMtYYdkoMESF4FeFX2pNI/YWa4jQeQtbPV
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,287,1669100400"; 
   d="asc'?scan'208";a="136572823"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2023 08:23:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 08:23:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 10 Feb 2023 08:23:23 -0700
Date:   Fri, 10 Feb 2023 15:22:58 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>
CC:     Guo Ren <guoren@kernel.org>, <arnd@arndb.de>,
        <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <mark.rutland@arm.com>,
        <ben@decadent.org.uk>, <bjorn@kernel.org>,
        <miguel.ojeda.sandonis@gmail.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V16 4/7] riscv: entry: Convert to generic entry
Message-ID: <Y+ZhUuCKm21FiuWc@wendy>
References: <20230204070213.753369-1-guoren@kernel.org>
 <20230204070213.753369-5-guoren@kernel.org>
 <D6D12456-3A6F-4AD2-B5D8-4DD83C8D0DE6@kernel.org>
 <CAJF2gTTFb+h-tzTiwj=SBjEqjRwbsRvCn=vpvdW26aEaqc_Z3A@mail.gmail.com>
 <A1D7112B-5738-4DF5-906B-76535647EF28@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AJFLSkFu3rFIM/YT"
Content-Disposition: inline
In-Reply-To: <A1D7112B-5738-4DF5-906B-76535647EF28@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--AJFLSkFu3rFIM/YT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

On Sun, Feb 05, 2023 at 03:04:37PM +0100, Conor Dooley wrote:
> On 5 February 2023 14:56:01 GMT+01:00, Guo Ren <guoren@kernel.org> wrote:
> >On Sun, Feb 5, 2023 at 6:43 PM Conor Dooley <conor@kernel.org> wrote:
> >> On 4 February 2023 08:02:10 GMT+01:00, guoren@kernel.org wrote:
> >> >From: Guo Ren <guoren@linux.alibaba.com>
> >> >
> >> >This patch converts riscv to use the generic entry infrastructure from
> >> >kernel/entry/*. The generic entry makes maintainers' work easier and
> >> >codes more elegant. Here are the changes:
> >> >
> >> > - More clear entry.S with handle_exception and ret_from_exception
> >> > - Get rid of complex custom signal implementation
> >> > - Move syscall procedure from assembly to C, which is much more
> >> >   readable.
> >> > - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> >> > - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> >> > - Use the standard preemption code instead of custom
> >> >
> >> >Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> >> >Reviewed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> >> >Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> >> >Tested-by: Jisheng Zhang <jszhang@kernel.org>
> >> >Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> >Signed-off-by: Guo Ren <guoren@kernel.org>
> >> >Cc: Ben Hutchings <ben@decadent.org.uk>
> >> >---
> >>
> >> Got some new errors added by this patch:
> >> https://gist.github.com/conor-pwbot/3b300050a7a4a197bca809935584d809
> >>
> >> Unfortunately I'm away from a computer at FOSDEM, so I haven't done an=
y investigation
> >> of the warnings.
> >> Should be reproduceable with gcc-12 allmodconfig.
> >Thx for report, but:
> >The spin_shadow_stack is from '7e1864332fbc ("riscv: fix race when
> >vmap stack overflow")'. Not this patch.
> >
> >New errors added:
> >--- /tmp/tmp.nyMxgc6CGx 2023-02-05 05:12:59.949595120 +0000
> >+++ /tmp/tmp.5td5fIdaHX 2023-02-05 05:12:59.961595119 +0000
> >@@ -10 +10 @@
> >- 1 ../arch/riscv/kernel/traps.c:231:15: warning: symbol
> >'spin_shadow_stack' was not declared. Should it be static?
> >+ 1 ../arch/riscv/kernel/traps.c:335:15: warning: symbol
> >'spin_shadow_stack' was not declared. Should it be static?
> >@@ -9109 +9109 @@
> >- 37 ../include/linux/fortify-string.h:522:25: warning: call to
> >'__read_overflow2_field' declared with attribute warning: detected
> >read beyond size of field (2nd parameter); maybe use struct_group()?
> >[-Wattribute-warning]
> >+ 38 ../include/linux/fortify-string.h:522:25: warning: call to
> >'__read_overflow2_field' declared with attribute warning: detected
> >read beyond size of field (2nd parameter); maybe use struct_group()?
> >[-Wattribute-warning]
> >Per-file breakdown
> >--- /tmp/tmp.bHiHUVMzmZ 2023-02-05 05:13:00.109595117 +0000
> >+++ /tmp/tmp.kUkOd6TrGj 2023-02-05 05:13:00.257595114 +0000
> >@@ -1197 +1197 @@
> >- 65 ../include/linux/fortify-string.h
> >+ 66 ../include/linux/fortify-string.h
> >
> >Seems the line number change would cause your script to report old
> >errors as new. So it would be best to improve the check script, such
> >as ignoring the first column line number :)
>=20
> I thought it already did!
> I might've messed up in a refactoring of the script.
> I'll fix it up when I get home so, sorry for the noise!

So I finally got around to trying to sort this out.

>- 1 ../arch/riscv/kernel/traps.c:231:15: warning: symbol
>'spin_shadow_stack' was not declared. Should it be static?
>+ 1 ../arch/riscv/kernel/traps.c:335:15: warning: symbol
>'spin_shadow_stack' was not declared. Should it be static?

As you pointed out, this one is just the movement of an existing error
but isn't why the automation complained about the patch.
That said, should probably be fixed by declaring it in thread-info.h
alongside shadow_stack?

>- 37 ../include/linux/fortify-string.h:522:25: warning: call to
>'__read_overflow2_field' declared with attribute warning: detected
>read beyond size of field (2nd parameter); maybe use struct_group()?
>[-Wattribute-warning]
>+ 38 ../include/linux/fortify-string.h:522:25: warning: call to
>'__read_overflow2_field' declared with attribute warning: detected
>read beyond size of field (2nd parameter); maybe use struct_group()?
>[-Wattribute-warning]

The 37 and 38 here is the source of the complaint though, this series
added an extra one of these warnings, so I don't think the automation
has done anything wrong here.

The number comes from the output of:
grep "\(warning\|error\):" $tmpfile_n | sort | uniq -c > $tmpfile_errors_now

And that appears to be correctly reflected in the report:
build_rv64_gcc_allmodconfig	fail	Errors and warnings before: 17343 this pat=
ch: 17344

However, I should probably go and do something to display the LoC that
caused the issue, since knowing it came from fortify-string.h doesn't do
all that much to help you know which change caused it to appear.

Thanks,
Conor.


--AJFLSkFu3rFIM/YT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+ZhRAAKCRB4tDGHoIJi
0g0JAP0b4fo/nTYSwqwmMxxca6d11n7La9RaH0WmjVkgHg44dwEA6m309zaBWEfZ
APV1TVTzKmLZyFvvmewSEdHfcFUfVQM=
=fAgh
-----END PGP SIGNATURE-----

--AJFLSkFu3rFIM/YT--

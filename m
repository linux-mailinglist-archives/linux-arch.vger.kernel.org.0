Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F193D2498
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhGVMra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:47:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhGVMr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2021 08:47:29 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGyl3-1ltaAy0ilX-00E9lL for <linux-arch@vger.kernel.org>; Thu, 22 Jul
 2021 15:28:03 +0200
Received: by mail-wr1-f46.google.com with SMTP id i94so5950828wri.4
        for <linux-arch@vger.kernel.org>; Thu, 22 Jul 2021 06:28:03 -0700 (PDT)
X-Gm-Message-State: AOAM533Lldmb74X32djIN79YroIcFVutLXFy8UPvIwhaX3Rz5B8KFXql
        BJDEDNDYGyka/rZpugWXAjIkklKC5XkK+9lIs7o=
X-Google-Smtp-Source: ABdhPJyEeRh/i7uy8XM9NvCuzeD2SadMHGpmQsjRneZJUju2Crztab4RhvWfH6JSCd3qCw/c6BFO+frodmECiKxCuHg=
X-Received: by 2002:adf:f2c6:: with SMTP id d6mr49636087wrp.286.1626960482848;
 Thu, 22 Jul 2021 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <202107222016.1Ulr7QC7-lkp@intel.com>
In-Reply-To: <202107222016.1Ulr7QC7-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 22 Jul 2021 15:27:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qym+oh_dQB-Mis1wnQVZRf6VGNys_o8EZdPE9Ft=SDg@mail.gmail.com>
Message-ID: <CAK8P3a0qym+oh_dQB-Mis1wnQVZRf6VGNys_o8EZdPE9Ft=SDg@mail.gmail.com>
Subject: Re: [asm-generic:asm-generic-uaccess-5 1/8] arch/um/kernel/skas/uaccess.c:246:17:
 error: 'src' undeclared
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EgmUbsycbriTiOeGk0oMWUFX6GaOUR216QGYvWCtkv4AYOLnSiS
 QHtKHQAg8kxLvIOtIikCbu46GnWyzdb4CqQK4NXzsdSTZZIR1bmnuJliRDZWEPQN0N7LOiT
 ov253pbUo1k3GklPbweoNBrzDpiAOtr59wGv0vE+aRKn+IlK61xrvvV+Na6LzHsWVuJw591
 5YTz9x/0iPs5dI6dMnj0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FD9omCeXbuQ=:AgVlClhKgHouwHePEorYaO
 xnJZpLqJvnkmLEFaErVHry1Cbhu39JtRnRS6vRXIkSrTt9aUNRvlUBGO9et2l1xnXOrAylzLt
 xrlSxLA2xOqd1lvWx/tzopHFtED600Lb+zDxboV2lcpoozzBMVzlT1vR2gqXMBvWdB7Uj/Qnj
 LxAwDnCi74ob106XGI/tldvKTmGrTiPfmAxvTaGX/MV2JkvS4vzPCNEIO8grO3IbY29v17HXi
 jYfkB0wx9k8svib+WgR3u+2nKvB2olrtYVNTSU7I46c/tj4sG4QZCf804kDP+PSvg6NebsKXM
 9y9a6vmM/aqW3JyWXzknU9aDZ3zuUXt/8WFOTZigq79WeHOUlP00pIpKJW9NU4HU2zPSSpKyC
 2Njsi9QynU+pjz0CbBcS7a1MD9qJ3aB2DZfEPEHGDGN1FxyVK3ARYbEqqD/qM3rds/nIW8PKn
 GebuHt56lTIAU9Z0kOyAJkZ5OWxoOql9JqVw8f4Yhpa9EpVCADzy0ZePngd7m6/dFxmwb+F72
 JIQcy5SOiM6hNVLjvuSVwzYgKY2Tb9HlAKU11w6B2IJx6auGk2ZJSnJPKI1a2OnlVPS+Z1hXq
 HsXBYmYOP6D1Es1oeZKw1eaWf+5SglVSERUr94TWwfwDwYk0Nl9S5vqETpxf7NykkaegXccEw
 e8lV1aFLIc2bnaZ8WZiRsU3BfRybjUPz9URu/VQXlYHbYHjAmyNuMxRgTWFl6JhHX4oSQu8R4
 VnCdZCyNdHitCCSExWcZViuBcXaSooMt3XwgJpx2xRyi1+Tgt7XSqb6259hQSuK2GpnBfzFqt
 JwjhUTwi/hC5d5WXAF2ccKxiCXVObVHrlX5wgGO620y3ypnhSRQ6APNrUD6oirc8XQCw8wx
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 2:43 PM kernel test robot <lkp@intel.com> wrote:
>
>    In file included from arch/um/include/asm/uaccess.h:39,
>                     from include/linux/uaccess.h:11,
>                     from include/linux/sched/task.h:11,
>                     from include/linux/sched/signal.h:9,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from include/linux/fs.h:33,
>                     from include/linux/highmem.h:5,
>                     from arch/um/kernel/skas/uaccess.c:7:
>    arch/um/kernel/skas/uaccess.c: In function 'strnlen_user':
> >> arch/um/kernel/skas/uaccess.c:246:17: error: 'src' undeclared (first use in this function)
>      246 |  if (!access_ok(src, 1))
>          |                 ^~~

Thanks for the report, fixed now.

      Arnd

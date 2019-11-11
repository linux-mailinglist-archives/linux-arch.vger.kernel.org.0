Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36FF7162
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKKJ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:09:27 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKKJ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:09:27 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplsZ-1i6pZu2YgP-00qAkb; Mon, 11 Nov 2019 11:09:23 +0100
Received: by mail-qt1-f174.google.com with SMTP id p20so15068843qtq.5;
        Mon, 11 Nov 2019 02:09:22 -0800 (PST)
X-Gm-Message-State: APjAAAWMTElxLIn+TusbrWobNiXOjtpxQMS46Ez741GNIi710E9PfCEJ
        U/6/TCNLB077W7zb1GM5toTYM3dBYCJyDVtd06o=
X-Google-Smtp-Source: APXvYqwUFI9CNnIwrAVKasmsTd09tLHKshCq1NYJLSrtULcDmOA+h22x7/m2tzlDDqS3Yhkmt+6zqdhU/D75oBqf0Ro=
X-Received: by 2002:aed:3e41:: with SMTP id m1mr16150881qtf.142.1573466961656;
 Mon, 11 Nov 2019 02:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-11-hch@lst.de>
In-Reply-To: <20191029064834.23438-11-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:09:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
Message-ID: <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] asm-generic: ioremap_uc should behave the same with
 and without MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WLrPbPJDqsNolBBa0EtV84o8X3QWGuIcje+jyjzvu8qxYvKalRW
 vVo3TWozXagE9Gvkhv9RKhJCAXh4rrcVLnVGcy2T4hm5OBp58YkOEUFIh/Am/mvfM7WC+1g
 94Ejh/WA6YNMtjZhLH3lXLLLVeLx0FrPhlZupRdQqVfwuImvK9gIMd+COj25ZFAUArh4v9w
 Wv1F7eDVgjndwTfa+DiwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DPxP3/AzH8=:DPOxQ1enriSFjxUu68vquX
 eGUcgshsAuMmTHkBY5dxmuUJPWWz6fubUKJoFZWeGiMRwxNYkQUHc74ubpDvEsEBOlQQ5kT8u
 f/aCJbLJc1CN7aYnn/FNDsbkGVuMUEpJE2tQVGEUyLPelCunzAJzsnukVx350hKhiVoG36wBL
 F3M/LNcc4vQE2KyZ7k7dfwsNgMUyYkUuiumKsP7EyaFU21YGtAQQjDL2ESuolSjkyTiGN5+jH
 G25CY3eWC9gJz/qY2zMyJ1QW1Mh46wHFF5wt+/j3PQHeltjdtINqad1SZ7OHQ/sEJkb9fbOBt
 9yyHmhrgWHj/dN55PM0GPvDdfe/5WlR3RDW46+W5XuZrPXJyk7FCNGxmtYlpvaA7D+PD1OPVR
 Ynfbi7O0CwVvlXzkvcjkRSEFFt4NYYcQy38A8NuxlRKVD/KL3uiCpxULhcPefsOtyWv4ecOSd
 CapTeIfnKNX7x8k3nxIrClwuCl01JQ1dHjqOwtbJSkf/JdQq1Mg+QRs1FmCVzafhM1mOL43Ab
 joYrEOzkOqPXLk9jXVvPuhAaoLoA3mP+DzFLVi1LF2iteAkmCqwdYNxlozO5bWCKFDECBEKvS
 ECBSQGX4K++EgBVd3QVoBipRwQMCLSpwD8tGk/dAPNG1cp6T00k88oSatqHkbN20tZrzvPnwz
 SyXdghQoLAHldOS9pIwizYXHqPmexdevUFWkAvVI1jPN1DybWWAQxUy6kVswrrVaFLUYpqWEp
 xr7k3KMT4BWFHMXUTuqI6PqyLm2zQou5Quti0hyT/vEOzOmrKm9cTozfJuvWjcGZ7dT+Gohp9
 hTPghZ5YdHuzcD0z2FaoD+G3QwPOi6fjkvhrW/e7iOJ/phyVUx2hqY3mfT1NmmBL7muZMzFXl
 nZROTB/e9eIAWJvNN9og==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Whatever reason there is for the existence of ioremap_uc, and the fact
> that it returns NULL by default on architectures with an MMU applies
> equally to nommu architectures, so don't provide different defaults.

Makes sense.

> In practice the difference is meaningless as the only portable driver
> that uses ioremap_uc is atyfb which probably doesn't show up on nommu
> devices.



> +/*
> + * ioremap_uc is special in that we do require an explicit architecture
> + * implementation.  In general you do now want to use this function in a
> + * driver and use plain ioremap, which is uncached by default.  Similarly
> + * architectures should not implement it unless they have a very good
> + * reason.
> + */
> +#ifndef ioremap_uc
> +#define ioremap_uc ioremap_uc
> +static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> +{
> +       return NULL;
> +}
> +#endif

Maybe we could move the definition into the atyfb driver itself?

As I understand it, the difference between ioremap()/ioremap_nocache()
and ioremap_uc() only exists on pre-PAT x86-32 systems (i.e. 486, P5,
Ppro, PII, K6, VIA C3), while on more modern systems (all non-x86,
PentiumIII, Athlon, VIA C7)  those three are meant to be synonyms
anyway.

      Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF33A31F1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJRWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRWr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 13:22:47 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CEEC061574;
        Thu, 10 Jun 2021 10:20:37 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso404222otu.10;
        Thu, 10 Jun 2021 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g6SU8s5JZXBpJRY7xHwXt52gkhZm/7vIqjpkQlZi7O0=;
        b=XskWsx9d/db0Cvo+2d6zFcITph7oWit0sJgLFcCJ366DC2XAxdjdrj031Idd1JG0g9
         8HVfEijZ9TBI0p5y9rJDU8wI/tTt3iN55nxQSwkWdwoNWWSxlrDLe/5C5IQw6Ghbafj2
         ZtjbvvcUflV4s/k2UOcjvgl63dPTj7/dCNv+25EbcHciiHbuaPGTa6F84d0Nt6W35X20
         5r1fJJktMsh+4dyxyG/LTWX/n9F2Qh5fwR/XN/Hv5lx8+nj7WveBkyia/PcKOcyMZOjn
         WC4kRyMGKNkVfFKBnfJ5i1kQer+4mEOozAZMemLnlsiyYuwwSpP2gYgUXDeLF+TPCiaa
         I5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g6SU8s5JZXBpJRY7xHwXt52gkhZm/7vIqjpkQlZi7O0=;
        b=n1YKHNmGZ4azIhwnVev+Wwu9ScQbh7S251DbuXxv2VHqRw5W5cfx0hDXUoyqipuwH1
         tQ9wPRWtuSgnCwdwbS4z206nNqQ2PXYSG396Jp4XBleAWI+6WM8dcddmKfFmQ0owWk4v
         4iBuhblklhRZ2XfZw+/y3U7svLBDZfWADQ07m17oYuQdrejIRdRg/A5rJSDJzN6cbe/Y
         hQRSiJX+Zn1N2bgwmJsisWY7Akyzeajip4aBMq1JO1ln1S5PIk5hGvrPcVIhb/k6jRYv
         sOiKCJ/RotSEBws4tw21j7N1lCoE+6Skz+DY/f41Io7o+k3WmSsqd5EGcTHbOu4Qu5VN
         lztw==
X-Gm-Message-State: AOAM5306iELtejkzYP18Rn8N56cJavoR82Gpzs9yZrHTYFv90+7gm3Q2
        zJdVXCRG/Chmx0cGxSB5a6Y=
X-Google-Smtp-Source: ABdhPJwwYHm+SgYEfCq2WkycRNl6JVPdshm4tyzMX1ooyqkhQpHuvr1tl5O15Ig2i59bbURiL2Bkzg==
X-Received: by 2002:a9d:7282:: with SMTP id t2mr3382022otj.288.1623345636778;
        Thu, 10 Jun 2021 10:20:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm634382oom.26.2021.06.10.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:20:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 10:20:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear
 mapping
Message-ID: <20210610172035.GA3862815@roeck-us.net>
References: <mhng-90fff6bd-5a70-4927-98c1-a515a7448e71@palmerdabbelt-glaptop>
 <76353fc0-f734-db47-0d0c-f0f379763aa0@ghiti.fr>
 <a58c4616-572f-4a0b-2ce9-fd00735843be@ghiti.fr>
 <7b647da1-b3aa-287f-7ca8-3b44c5661cb8@ghiti.fr>
 <87fsxphdx0.fsf@igel.home>
 <20210610171025.GA3861769@roeck-us.net>
 <87bl8dhcfp.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl8dhcfp.fsf@igel.home>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 07:11:38PM +0200, Andreas Schwab wrote:
> On Jun 10 2021, Guenter Roeck wrote:
> 
> > On Thu, Jun 10, 2021 at 06:39:39PM +0200, Andreas Schwab wrote:
> >> On Apr 18 2021, Alex Ghiti wrote:
> >> 
> >> > To sum up, there are 3 patches that fix this series:
> >> >
> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210415110426.2238-1-alex@ghiti.fr/
> >> >
> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210417172159.32085-1-alex@ghiti.fr/
> >> >
> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210418112856.15078-1-alex@ghiti.fr/
> >> 
> >> Has this been fixed yet?  Booting is still broken here.
> >> 
> >
> > In -next ?
> 
> No, -rc5.
> 
Booting v5.13-rc5 in qemu works for me for riscv32 and riscv64,
but of course that doesn't mean much. Just wondering, not knowing
the context - did you provide details ?

Thanks,
Guenter

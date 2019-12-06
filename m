Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E9611558D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFQg7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfLFQg7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:36:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB7E2173E;
        Fri,  6 Dec 2019 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575650219;
        bh=2H3ziaS3wSxYN2KRy/3/wq9E68TWEGzBwD5gyjiUZKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMLxrM14iP7T5hwxwaGBH+jV7xzG2sSAxPyomobXXe93MRL/+gyC6rYj5zWawvMv7
         wJ28xDTpb+r1h6LV3Miyk3tpgsq2DYLWo9Lp846xgWLWDtN0DutBNoO1eywkVV/iDA
         LGFS8MoTVGdP6JZ1KT80jsnd12PZ2yP/wR6LJIzs=
Date:   Fri, 6 Dec 2019 17:36:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>,
        Thomas Renninger <trenn@suse.com>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191206163656.GC86904@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-3-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206162421.15050-3-trenn@suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 06, 2019 at 05:24:20PM +0100, Thomas Renninger wrote:
> From: Felix Schnizlein <fschnizlein@suse.de>
> 
> Enable sysfs cpuinfo for x86 based cpus.
> Export often used cpu information to sysfs:
> stepping, flags, bugs, bogomips, family, vendor_id,
> model, and model_name are exported.
> 
> Sysfs documentation is updated to reflect changes.
> 
> Example (on a kvm instance running no an intel cpu):
> /sys/devices/system/cpu/cpu1/info/:[0]# head *
> ==> bogomips <==
> 5187.72
> 
> ==> bugs <==
> cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit
> 
> ==> cpu_family <==
> 6
> 
> ==> flags <==
> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat umip

One file with all of that?  We are going to run into problems
eventually, that should be split up.

Just like bugs, that's going to just grow over time and eventually
overflow PAGE_SIZE :(

Make this:
  ├── flags
  │   ├── fpu
  │   ├── vme
...

Much simpler to parse, right?

sysfs files need to be one-value-per-file, and that's a lot of different
values in a single file.

How did I miss that before?

> @@ -0,0 +1,99 @@
> +/*
> + * Copyright (C) 2017 SUSE Linux GmbH
> + * Written by: Felix Schnizlein <fschnizlein@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.

Boilerplate and SPDX.

You did run these through checkpatch.pl, right?  It should have
complained about this.

thanks,

greg k-h

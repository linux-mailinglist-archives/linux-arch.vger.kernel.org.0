Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC256CDD8C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJGIog (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 04:44:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:16703 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfJGIof (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Oct 2019 04:44:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="276727970"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2019 01:44:31 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHOd3-0005O0-Rr; Mon, 07 Oct 2019 11:44:29 +0300
Date:   Mon, 7 Oct 2019 11:44:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Subject: Re: [PATCH v16 11/14] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Message-ID: <20191007084429.GN32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <8e85aa4ccead5c330d7abdbda292f32a0c48902e.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e85aa4ccead5c330d7abdbda292f32a0c48902e.1570374078.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 06, 2019 at 11:11:08AM -0400, William Breathitt Gray wrote:
> Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> bitmap_get_value8 functions, where appropriate. In addition, remove the
> now unnecessary temp_mask and temp_shift members of the
> intel_soc_dts_sensor_entry structure.

Since it perhaps will be next version, I have few style comments here
(ignore them if you are not going to send a new version by some other reasons).

>  	int status;
>  	u32 temp_out;

> +	unsigned long update_ptps;

I think it's better to put it one line below.

>  	u32 out;
>  	u32 store_ptps;
>  	u32 store_ptmc;

> -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> -	out |= (temp_out & 0xFF) << (thres_index * 8);
> +	update_ptps = store_ptps;
> +	bitmap_set_value8(&update_ptps, temp_out & 0xFF, thres_index * 8);
> +	out = update_ptps;

+ blank line?

After this change it seems we may drop temp_out and use out instead.

> -	out = (out & dts->temp_mask) >> dts->temp_shift;
> +	temp_raw = out;
> +	out = bitmap_get_value8(&temp_raw, dts->id * 8);

>  	out -= SOC_DTS_TJMAX_ENCODING;
>  	*temp = sensors->tj_max - out * 1000;

We may also join these together, though it's up to you.

>  	char name[10];
>  	int trip_count = 0;

> +	int writable_trip_count = 0;

Perhaps move it after next line, or before previous one.

>  	int trip_mask = 0;
>  	u32 store_ptps;
>  	int ret;

> -	int i;
> +	unsigned long i;

We may skip this change, but if we go with it, better to place before
'int ret;' line.

> +	unsigned long trip;
> +	unsigned long ptps;

I would group each of these with relative group of definitions above.

>  	if (notification_support) {
>  		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
> +		writable_trip_count = trip_count - read_only_trip_cnt;

Maybe writable_trip_count -> writable_trip_cnt? (in align with r/o one).

> +		trip_mask = GENMASK(writable_trip_count - 1, 0);
>  	}

-- 
With Best Regards,
Andy Shevchenko



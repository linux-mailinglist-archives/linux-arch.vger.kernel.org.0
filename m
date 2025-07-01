Return-Path: <linux-arch+bounces-12550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCB8AF068E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 00:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938173ABE47
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A76302053;
	Tue,  1 Jul 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBKvK6La"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFE28313F
	for <linux-arch@vger.kernel.org>; Tue,  1 Jul 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408937; cv=none; b=nhaI63Fz6b30TMTDG1tWXxQzicdR+Q+sITneTKEWfj1Zd7GNwTVRNc2A3040ziUGROxsj9ahY1jaCifqc4vSPIv38iGp0YSViHdXNMCM98+kl5U7q9Xf9ADt0N6zYUz9msbgiilsfuH3Tg+sx9n9yiEsEMZSqUkkfHuUkKoSZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408937; c=relaxed/simple;
	bh=n0zYqPCVE63k96XgPVfhcuHHLz1NYO8p8V0IZj2IUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfk7PbT98Lsk8t0DLxXyLZxlyhk5TU1W5SIYUEMeqT20OqbslaMgafixwa+AyVAuztaxLorfu+yBeF4qARevMXEygNGNw0gqWJ/5cIeRmat2itL8uU90Ph+3wKAnah57wjvv+oiQWN+jQcws0OK5wIJPPC7Harmj0ThhitQaPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBKvK6La; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so5007846a91.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2025 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751408935; x=1752013735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqiBxCcJqjdjFF9qZ+Y4WTPM+XlqLow6zp0/7spPckM=;
        b=oBKvK6LaaGDploTzg3m0cEwRph9J59Ym10uGbzhqKKmE8nXf9oXATerqbwpnPmXWWK
         Tf2xoRG09qGC1ce7+YEQiu2WhMa36qVHB5i4YBVQfeMHzEzzgcmC2IfWo49Xew+Pci0v
         Wr91mIe+fQ/5SrvE71mFw+AZjqYb4B65X5fA55zQrcnVScjGUZZGHK6LG3Lfz5m/Rc6k
         tT1bMmGE9s4C51lqwMezAacRpuX1KUq+nxdg5Qmdr+mfTbwkUB/w/ObWeLceMIsCgBrJ
         /BLoyiPqftc2PbVofotq3yK9Z3Mq7G1baTBI+klhf7KzqFu96EFe7ipmreBCzPpl7+tt
         IE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408935; x=1752013735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqiBxCcJqjdjFF9qZ+Y4WTPM+XlqLow6zp0/7spPckM=;
        b=XIoP7M9G6mFqL3vY2/11EL4Hf+LUw6jTNCjFmLxrCztMkpX6Cn9uNgVglziLXi3AhC
         sYc44gflKMv9bwPmJam9PON/s13YoWt6WFO/BHVPFEgSmd42nGPSuZJYmBWI3rmDCIQJ
         7hQ4gJqWxXkg7TLoq90STipqAF4NvFOKeK9IZjyh6W1pDIUac37Xlj5qQEw3hH3VaS2j
         zGjxWO1JcjHb7wuHJ/ftgIdfuPXDm5XOxviseIDfQL1WkTAhv9NN5s6h1OPnkU+HQL/K
         Bn54b4A+QoGvvNVBzuRbs1XHAhurTaKVwPT5IvrV5xzmDivsAL4RIbb1KiJdY26Ab8N9
         2Q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWauokeMFqAloNUXRDpDv2gFTRqDDrIiNytrkf2xI+dErJvFd3yix+3H1xctDPVSYhb6lB1wPlEjtMx@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpJAHze2P+uBjJAxzK6crk8tA0VbTO3RSdx5kBg1xaQQcc9p1
	OYb7PSsPod7R6G8zyp7NIG0nWMF8b34gen20Yz1Ev7Fxg7BpmEwu16gbQBNgS9J55g==
X-Gm-Gg: ASbGncsL5U+QvTqrRIgnH5edXTnBZnnODiRE6yIs+WOXvZnLcJ994nOF5OM6oF7enj5
	0v5R3n6Vt9+omRSB0CoeQYPtxxAO/sXJhQQ24yd6zN6/Rx5MDfbP0y89TOhn9in0fo/BshXfskx
	JgcRUL7T/yCsyumvsxfYPZDTdMd6nYOu5EZATLQ0eGbNGvJUa5KCBJFe8h5MMiMIRmKJqeUV3aq
	seUtMo5E2X6bQ+bb6lqdmHap2OZgRqET1ZCWxni0Y2nrbxlyWNggVzq15ZOlSX8paZyhO5TOWbF
	NKsiLwOZZe5PLDaRNLqMUTLWekQ9E3GtU4RWecNWuzjaGuVX0LanYptslGQ9S0whFuWzhlGvEOy
	GYlPsKVprtz2+82M2b57pgpCmEnDRSET+qAG8uA==
X-Google-Smtp-Source: AGHT+IFO3NokN4KNGADvJFc+QyaXPg6XAaPe9Y5humRIo4oqN4AIbrSdsYHREKK5CqDhUkeltCAELA==
X-Received: by 2002:a17:90b:5787:b0:311:9c1f:8522 with SMTP id 98e67ed59e1d1-31a90b2a07amr970706a91.10.1751408934848;
        Tue, 01 Jul 2025 15:28:54 -0700 (PDT)
Received: from google.com (96.41.145.34.bc.googleusercontent.com. [34.145.41.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c15233d0sm12834811a91.46.2025.07.01.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:28:54 -0700 (PDT)
Date: Tue, 1 Jul 2025 15:28:50 -0700
From: William McVicker <willmcvicker@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
Message-ID: <aGRhIrZq1tMR8yGO@google.com>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
 <aGQnOMDyBckks78k@google.com>
 <92daf35f-9240-450f-a05f-b7869fafeb6b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92daf35f-9240-450f-a05f-b7869fafeb6b@app.fastmail.com>

On 07/01/2025, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 20:21, William McVicker wrote:
> > On 07/01/2025, Arnd Bergmann wrote:
> >> On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
> >> >> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
> >> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
> >> >>  #define OF_DECLARE_2(table, name, compat, fn) \
> >> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
> >> >> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
> >> >> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
> >> >
> >> > To support auto-module loading you'll need to also define the
> >> > MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
> >> >
> >> > I haven't tested the patch yet, but aside from my comment above it LGTM.
> >> 
> >> The patch doesn't actually have a module_platform_driver_probe()
> >> yet either, so loading the module wouldn't actually do anything.
> >
> > Probing with TIMER_OF_DECLARE() just consists of running the match table's data
> > function pointer. So that is covered by Daniel's patch AFAICT. However, it's
> > not clear if this implementation allows you to load the kernel module after the
> > device boots? For example, will the Exynos MCT timer probe if I load the
> > exynos_mct driver after the device boots? My guess is you'd need to register
> > the device as a platform device with a dedicated probe function to handle that.
> 
> Yes, that's what I meant: the loadable module needs a module_init()
> function that registers the actual platform driver in order for the
> probe function to be called. module_platform_driver_probe()
> is the way I would suggest to arrange it, though that is just a
> convenience helper around the registration.
> 
> The platform device at that point is created by the normal DT scan,
> so there is no need to create an extra one. On the contrary, in case
> we successfully call the probe function from timer_init(), we end
> up with two separate 'struct platform_device' instances 
> 
>      Arnd

So then does it even make sense to have `timer_pdev_of_probe()` if it's very
unlikely that the module will even be loaded by the time `timer_probe()` runs?
Would it make sense for TIMER_OF_DECLARE_PDEV() to just have a special else case
with the module boiler plate stuff for when the driver is built as a module?
Something like:

--->o---

#if !defined(MODULE)
#define TIMER_OF_DECLARE_PDEV(...) TIMER_OF_DECLARE(...)
#else
static int timer_pdev_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	int (*timer_init)(struct device_node *np);

	timer_init = of_device_get_match_data(dev);
	if (!timer_init)
		return -EINVAL;

	return timer_init(dev->of_node);
}

#define TIMER_OF_DECLARE_PDEV(...) \
	OF_DECLARE_PDEV(timer_pdev, name, compat, fn) \ # make this define MODULE_DEVICE_TABLE() as well
	<create struct platform_driver instance> \
	<call module_platform_driver_probe(..., timer_pdev_probe)
#endif

--->o---

--Will


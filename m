Return-Path: <linux-arch+bounces-12589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98804AFB6B9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C643B7E5C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A572E1C7C;
	Mon,  7 Jul 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9t1rKcu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D482E11D9
	for <linux-arch@vger.kernel.org>; Mon,  7 Jul 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900559; cv=none; b=BjvXynfWCEqojuTxJhypLEsPHN0d5iGxZmrcWGkNzLfTGdkazdD2ysm/HZFkA9xoXkZ5sIG262SThL6xnnhN9P6isM12fFQ0B58K4MAalPSWCvFZVKOmPJMzdbTKvxwj/I5zavxIh62G+VTj+vL8bj1Zz9UuYHGQMkbFRKabDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900559; c=relaxed/simple;
	bh=i7sfTjCF/E/d1O9h/ifiO3nu9T3lIoOxDIwxNqiTT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpRVg+0nxdjxrmNNrK3r8RZqATLAWijvIZYzdAupJzBMiQQLRTe/HagBjlxysZAy/9CUKMdwGCvcV/fjC7uWm3WR/qBAy4d1xAeJ0tBeppj6k33NUV1ZZrjb/kb4M+DvL82dAr80JZkVIyI6DaiNZpbgCY3wdvrFyOywZxKriuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9t1rKcu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3188387f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 07 Jul 2025 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751900554; x=1752505354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fl/J0VEiX3HHsALj1wh9p6wJy+RRju7SSWQFr2CSlj8=;
        b=J9t1rKcuumXHh3RwlHIcBxko2s38vYv+1mxqpBN1hWD6jrq+oPd8zsOxJ+VrBO4JOZ
         ethj7Va+QDYm2nz/BQbp+dGBK0nV1W5BcizGCbQwwG7pGDArkg85uuQv2j3UHPAErxmh
         XLx0sJqeYWc26EeSDbyhHVJaYQ0eSzxscmjeA0IkWOOjNSrUbYusX9Gu/wIAGjl0HY7E
         p9t2gwfGX/UcLQTSSATCeCMW0cx3j9z8zIlj4SigZnGO3VzEHs56jw/Y+ewI82LV+K8d
         kxRbFmn0urW+j5xLTO9F3lyfvhXteM2s1g/iVYfrAzQxzlPOiYPNDCY0gmYsLYJKm8/J
         ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900554; x=1752505354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl/J0VEiX3HHsALj1wh9p6wJy+RRju7SSWQFr2CSlj8=;
        b=Qor+J+OtjcC8R+32Q9MtlqEvzS0glpm1Q8Q4i1p/fS8mlw9N4tABWEobS8y8pJo++8
         N3js/xeAWeRi/dvQqRhnOi3buaXStZPl5vc+lWYdvWgy/ShETIaxZ+u2RwmHunJtzB0b
         CSMPg9RR+GKjTskisyzFpzCumyJOFLqoJNBglvnClpPDcNK8cZWWlVaIcJ8cfRynceNK
         8oSp+xFhaghJCcf5ahf2FsfjecNINbW4MyRnu1kXxevLkJdffWPH/tvixHmkaaN6wKLC
         34D+InFa4JdxalQMk1DWIRYpntS1k7ex9C0qEkZ9K2LEiXo4w0JcnYMUwfumRthqtLFz
         MsYA==
X-Forwarded-Encrypted: i=1; AJvYcCWli6SxwQxh3B7TgmqFTsihwh8EV2Yo8gsa9UQHZ/J6KttwX5CB8cz0pbgLRuZ+q60RkW5mrp7fmrm7@vger.kernel.org
X-Gm-Message-State: AOJu0YwScATrV2dUwzN6qidtUQjbYdmakfmuEmHWrtM3HWKTIp0/0Cwi
	gfUYwGg925EC7hV7Ss0yXsHgBb20G5+ubJwQFdjhGLh4tAaslc6jDHEED0dhiJhfZP8=
X-Gm-Gg: ASbGncvWeAaCEhL3mTgdfVliMxzkwTh9tTCf7r/2cP3eQ3Mev3XO4Gxtuj6ogs3bD7L
	ocYAlOafUmIIiz7eydxmAYSyBMPfbqoEawdPtgFVDAky4rXKV77cJDKbI+uabD0E4JCJSvxoA9M
	y5SZuL7yabHweUF57PomJ95s8RcQaQAFHsnJagZhnjuVjtRyViH/804B5uTOEa2PMMu2zgVUEfb
	/+jTEE/ECum/O+qmbqsVnA4IuRxU7boKnPy+jXmNfoWSDT1yPqpimzNQ/FnigeeuYb3YFjAt01l
	xiiadkSsxfxj/bPjwfiwPp8YZARFPtKEtZFtiFgQHfz0W/ykekPPA/jRU2/znAbkgHG8ujyHr4Z
	k/36IiMXyoq6xF5aho0h1Jewv
X-Google-Smtp-Source: AGHT+IFD1Qu0LW6oYZ+Lwxtvfg4kO82KZunY4+lyRPiPRJMlKuQa4HwFYYu7m5svgNaruht1xrRyug==
X-Received: by 2002:a05:6000:2f8a:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b49aa74223mr6787123f8f.34.1751900551836;
        Mon, 07 Jul 2025 08:02:31 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966c0sm10636203f8f.52.2025.07.07.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:02:31 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:02:29 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: William McVicker <willmcvicker@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <aGvhhcCd2rIuY4Zd@mai.linaro.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
 <aGQnOMDyBckks78k@google.com>
 <92daf35f-9240-450f-a05f-b7869fafeb6b@app.fastmail.com>
 <aGRhIrZq1tMR8yGO@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGRhIrZq1tMR8yGO@google.com>

On Tue, Jul 01, 2025 at 03:28:50PM -0700, Will McVicker wrote:
> On 07/01/2025, Arnd Bergmann wrote:
> > On Tue, Jul 1, 2025, at 20:21, William McVicker wrote:
> > > On 07/01/2025, Arnd Bergmann wrote:
> > >> On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
> > >> >> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
> > >> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
> > >> >>  #define OF_DECLARE_2(table, name, compat, fn) \
> > >> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
> > >> >> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
> > >> >> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
> > >> >
> > >> > To support auto-module loading you'll need to also define the
> > >> > MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
> > >> >
> > >> > I haven't tested the patch yet, but aside from my comment above it LGTM.
> > >> 
> > >> The patch doesn't actually have a module_platform_driver_probe()
> > >> yet either, so loading the module wouldn't actually do anything.
> > >
> > > Probing with TIMER_OF_DECLARE() just consists of running the match table's data
> > > function pointer. So that is covered by Daniel's patch AFAICT. However, it's
> > > not clear if this implementation allows you to load the kernel module after the
> > > device boots? For example, will the Exynos MCT timer probe if I load the
> > > exynos_mct driver after the device boots? My guess is you'd need to register
> > > the device as a platform device with a dedicated probe function to handle that.
> > 
> > Yes, that's what I meant: the loadable module needs a module_init()
> > function that registers the actual platform driver in order for the
> > probe function to be called. module_platform_driver_probe()
> > is the way I would suggest to arrange it, though that is just a
> > convenience helper around the registration.
> > 
> > The platform device at that point is created by the normal DT scan,
> > so there is no need to create an extra one. On the contrary, in case
> > we successfully call the probe function from timer_init(), we end
> > up with two separate 'struct platform_device' instances 
> > 
> >      Arnd
> 
> So then does it even make sense to have `timer_pdev_of_probe()` if it's very
> unlikely that the module will even be loaded by the time `timer_probe()` runs?
> Would it make sense for TIMER_OF_DECLARE_PDEV() to just have a special else case
> with the module boiler plate stuff for when the driver is built as a module?
> Something like:
> 
> --->o---
> 
> #if !defined(MODULE)
> #define TIMER_OF_DECLARE_PDEV(...) TIMER_OF_DECLARE(...)
> #else
> static int timer_pdev_probe(struct platform_device *pdev)
> {
> 	struct device *dev = &pdev->dev;
> 	int (*timer_init)(struct device_node *np);
> 
> 	timer_init = of_device_get_match_data(dev);
> 	if (!timer_init)
> 		return -EINVAL;
> 
> 	return timer_init(dev->of_node);
> }
> 
> #define TIMER_OF_DECLARE_PDEV(...) \
> 	OF_DECLARE_PDEV(timer_pdev, name, compat, fn) \ # make this define MODULE_DEVICE_TABLE() as well
> 	<create struct platform_driver instance> \
> 	<call module_platform_driver_probe(..., timer_pdev_probe)
> #endif
> 
> --->o---

Yes, that is exactly the goal :)

The RFC was just for the timer-probe function, I was unsure about its
validity. Let me resend with all the changes for the [no ] module
support.

--

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


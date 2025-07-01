Return-Path: <linux-arch+bounces-12547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673FEAF02BF
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 20:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9C3A8903
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A56280303;
	Tue,  1 Jul 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE9+G5p1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933527AC44
	for <linux-arch@vger.kernel.org>; Tue,  1 Jul 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394111; cv=none; b=C7LMCg0vKRVrbRuNBXkr3oI6uMePONWwH61hVIAUJrLeUhIcQ4DNQWd3GfAxpBKKMIc8ks16Gi3+uf8uG2jYjTHEfKH8CE7sjC0ljif4pqe1mhFKNZqR5hRo0Hnv29hTWrSGFF4AbL9mWl/0qgDfWkpRdntQZP4DH+KX3xLnrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394111; c=relaxed/simple;
	bh=/0iJBVR02jp37VuAafJ7AuWu4zYV4ay0z9SBj/41vLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTsL9A4dOLkiy55QBduJlN1xLPt+iuIZVrGPfqQSEoGiA0gevnEEeSdkScsqItsyr+zkF3vRaMK6azUab49zRwiAguJatkI0nXcgyUdKAOso9OxfISYL8lOBRGjRfI3VE/JSO/IC9d4QkNTBUNxYztHC6HO4mrh4OaJRbZ8xRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mE9+G5p1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490702fc7cso4376201b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2025 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751394109; x=1751998909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QHb5QMnCyf1ixMGPEq1YYVlFE4mdK/TuEdnUZ7pL8k=;
        b=mE9+G5p1V3qKpkKKo/MkHwQmLdwW5CbUu0EwpgarGgURXhTUBGiQ7QTNW4a6AkfFdl
         /zsaLq+aG1182QuFEAVOCVgpVKfq1g/yDce2HlfZ+CQT/0CxGtvEh+HbPTSxxWFY2vyy
         OO8hWkOUxKBp0pfsKYn0IQF6ZKFLcHHSGPx8XkC2qgFT95Ty4ZgkLEnyj1tOAliCIJDm
         yGWa7PHiLnD4jT1zohGoIuvCFs6SbwPR5k+YYfAeo8yetwxG4Zy59JoZkadLteOT1bO8
         NiToHN77IVQu+P2wz/MQCVCdB6I41lN3CPTniQbZuZ4nvay42Ml5HseMb77R4ZyoatkB
         AZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394109; x=1751998909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QHb5QMnCyf1ixMGPEq1YYVlFE4mdK/TuEdnUZ7pL8k=;
        b=WOx2Qtn6/Hq/cyUufyra+5bhL3yYgkydBxTS+RYSRFAJS3GS+7eKhXbU4nkXFX8SX6
         /jaJIPgIVlMgGUOWiUy6guAc5Zc7iqBky48V3krGLaDEkpjpsZJAmGSs0gYggE+8oAAq
         PXTbhgFdexuFvu9Uk/s2fBmm38leGyXc8pgTVKvqXUA1MS2o9mGiU6+hASbDmXkJ2ZVx
         qFAQwjOywijyULMANDVfv9ispMzKi4HGRSnKpY1xMWMExSRra7Uv70Z6KfGuz8Q2wtnf
         1rZuzU3nKV8WaWZl36Pdp8cdnoSAch74QWmwmVzfAXz262M46F3uR1l7WCsOBKY/Fz4J
         YW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBTwsygWp85WXi7p8EnwKWOL4v81ZfHb/jTQGljXNPy6St91E05Y3nvYwJh58+acvEj2vQ5/4HBcli@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV8NCwSPrqHIkOVgmqketPGYodo7qC3ZEUAFr9H2982uZ0dKD
	sB9vWymWOBO4KGBifipcSw1Vxa1UKk1l6zznxzOtwvaSpKwU1Qh+Y+nXc09V6mCEyQ==
X-Gm-Gg: ASbGncuxVf/yb2zew8vxoRVm/BZJNOsMpkoi8CY+iWygQYTgcVIC9zssyEtY8b4i0zz
	RElibA6Nzuo22zCdfCpKX3Zonh6NEFNRa+7/USRvixFxFxJoZJgiEtaxDiDPud7YEhDurY+B1lU
	lbhIEBmtgxls9/3rVG4FJlhw258G2ETvoEVkAiS4PzdUCcUxkSLhiEZcnEw4bv1k6RDwByxeRYm
	M50WQijKnd1h/+jNxLIzOWIPE9h/gRYX4Iztf9uc693WVBf2jaViVH72N2W5IvQN4y4H15kYz0b
	pLgmC+9mLu08cSLI6aMDZDab5BGtN2ZKSW5ZMlM9hKMRrrTHHYsOPmRRnxvMUyB7yag4QZflKbj
	3gJwX2yxUx+jWBD1H9jBnaNYNslw=
X-Google-Smtp-Source: AGHT+IFT0hH3Zk3DfXjOeWqqGBpHUpAxwE5lOf7WjFh0UeT7y+ZsuOyfA7fRcSglkCBF0+s+7klyww==
X-Received: by 2002:a05:6a00:464f:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-74af6e791dfmr26589635b3a.7.1751394108946;
        Tue, 01 Jul 2025 11:21:48 -0700 (PDT)
Received: from google.com (96.41.145.34.bc.googleusercontent.com. [34.145.41.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557460fsm13133161b3a.93.2025.07.01.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:21:48 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:21:44 -0700
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
Message-ID: <aGQnOMDyBckks78k@google.com>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>

On 07/01/2025, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
> >> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
> >>  #define OF_DECLARE_2(table, name, compat, fn) \
> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
> >> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
> >> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
> >
> > To support auto-module loading you'll need to also define the
> > MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
> >
> > I haven't tested the patch yet, but aside from my comment above it LGTM.
> 
> The patch doesn't actually have a module_platform_driver_probe()
> yet either, so loading the module wouldn't actually do anything.

Probing with TIMER_OF_DECLARE() just consists of running the match table's data
function pointer. So that is covered by Daniel's patch AFAICT. However, it's
not clear if this implementation allows you to load the kernel module after the
device boots? For example, will the Exynos MCT timer probe if I load the
exynos_mct driver after the device boots? My guess is you'd need to register
the device as a platform device with a dedicated probe function to handle that.

--Will

<snip>


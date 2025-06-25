Return-Path: <linux-arch+bounces-12454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A9AE82A6
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB11721CD
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EDF25DB0A;
	Wed, 25 Jun 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCxHVwCk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A625CC47
	for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854341; cv=none; b=kcfCMuc24zAtrNBTHOHaQ19AZPiZ4fvuZDG/3pXw3RDJvYOpHz3bZ8PobEwE/GCcn3E7qn4zEr0/1Mrt+I+9d0NAno+95cPefF7P5rSaWhEUsy2ynNvYZBdou4lOFjk0TVaPBLDPBS2zbdcrXoB8T9BW+xFIQsmGOBafV+VdiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854341; c=relaxed/simple;
	bh=//cJ1R+qXYIOQavXZE+0EfDVpn3NcjvwbOGFUZ2/Vwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgHJLTQDMmvzF+tOPbq7yGvGPzKIwiA0jKtvT9G9htyxtJhxIhO4apEcL0kAq/5dbJzirLxBWkOdvc//dwUUrle1ZkmSo3ODCK2kGszD+YeelH5thR7wTW7cJC9aYPXdGzXFiTycuT0oMGB7KobS9TJFkMkCq7n6vsoOpSajJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCxHVwCk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so3084126f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750854338; x=1751459138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvdYN44TiNs68JwW8S/yVlosf8CSUIVEdttnuRdhms=;
        b=zCxHVwCkfaQ4LHLv/3m74JXelo22PY+sC7dDVAXFHMHi1jCqWTrOazh3mDuUo0WLdi
         VDA+OMfjFf0yFpkS7qy8R0XmLME78CjlPIqS0b+mD8BjOukDLADEj9xg3WhWJlrIwNFq
         zfWMDKtpwn48ui6gBlIHDVTZmdkaVR3HD8ESjAxZsuNWpOeeWhiJTjqLGi0d7ouHsncu
         ubVT6+xrJxEp+ztXLPD6HxxxNGcj3sJh6ZSmuCX8QMCIXtEoZXXbNwnef6g4Mh57rF2i
         iMgerkqPi6NPV6ZDXB8vjzALmL+495xt6ZBF7UdkfNuftyrIAPwkQJGcdZRZ0cJWwjF9
         1qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854338; x=1751459138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jvdYN44TiNs68JwW8S/yVlosf8CSUIVEdttnuRdhms=;
        b=TXjP7EDLVnYqiJIfMVJO7NjYXcwaI039f/xl4jc6zkB7n3JLITjbPeZ2lqkTP2Aza2
         JnnQHQeLBuOT6KxaAsrq4ewpP+WzBCPdgT3f9JR5GmWOrTxvBm+B4SeLkVQei96J5RB1
         zxLz7UPI4n0Cpm0nD04qNfpp4MCWF3eOJ1C3lTPtmIBxXgHBf4YnwQ4QcuF9V8vBzJ0D
         2pOrHxMhhZ2GOnI3eLAH2n7Rqt34AgyM4SUq4iIoUO1ulizFsTT8EkB0o8su14l9V8JF
         c+pjd0pPwIqJzITAXb2XFyqK8NNbjf6cisuTvqu6Kpoc7k3oIJeDuqq1Ox9Z14c/RGij
         qTEg==
X-Forwarded-Encrypted: i=1; AJvYcCVmz2fi5MUlmyd/NqMhs4QbDiw8E8VArbB4Z0eza7AWPsi7W+saue1Q1f9fZo6zOo7JEdOm+fgEbBgi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+4uUOel+yMtxn+SpzTtwsaF2lYEQ3zMbcxB0qk6+qWEoBft7
	QNtqSCLxv+KRqidnXbjCJQDdewIhqB37wC1WEWwAYwOgktILT7ZNrBwwxVazvZG584U=
X-Gm-Gg: ASbGncvo1Y/yVohJ4R44U/f5iSkq3fGxTiU68HSA3KBli6/KKm8czjth7k7kpeDBqv6
	E0ufteoSGqmbAIX4VW8VzxwayQHnq/8TrFJx1TicD8WJVG5jFmo9FJjFcUMAqZ/L9eceWkuhnR5
	meMHj+IPr/2R6EsRFC4TauEc0En5fzEebqMomD1/JvRZtsPAtcR+To0xsHpJwE66G8HYT6JpD/e
	pywYkrkzcsZzXayqdoJO8+XAbFw1lirrsQBJTPVO43Go29kcL4a89T4u5bLBO33UH4eZUvmN005
	yqCVoOnZRqCSRyrDATjOsi5ijc4IEuxdCQe9JD6PIw80RhK+BXsCl7C/dn5mV3opWa6pbiukLLL
	eef+E3FiJaliC2llGWNnT6OBCGw==
X-Google-Smtp-Source: AGHT+IFext7dCx/qknWBCJpjQqXsjhcdgrzm4hickPzaUez5YIOyJ1vzQGCH42r2f1t3xxF9+iiC0w==
X-Received: by 2002:a05:6000:4615:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3a6ed5e9bf6mr2043160f8f.10.1750854338131;
        Wed, 25 Jun 2025 05:25:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45382373c6esm19046175e9.34.2025.06.25.05.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 05:25:37 -0700 (PDT)
Message-ID: <44062b00-8903-49e5-922e-aed68c377c70@linaro.org>
Date: Wed, 25 Jun 2025 14:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@linaro.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <e557503b-ccd5-46e2-b0b6-e8db30ad0ac4@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e557503b-ccd5-46e2-b0b6-e8db30ad0ac4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Bryan,

thanks for your review

On 25/06/2025 12:20, Bryan O'Donoghue wrote:

[ ... ]

>> +
>> +    for_each_matching_node_and_match(np, __timer_pdev_of_table, 
>> &match) {
>> +        if (!of_device_is_available(np))
>> +            continue;
>> +
>> +        init_func = match->data;
>> +
>> +        pdev = platform_device_alloc(of_node_full_name(np), -1);
>> +        if (!pdev)
>> +            continue;
> 
> Shouldn't this be return -ENOMEM;
> 
>> +
>> +        ret = device_add_of_node(&pdev->dev, np);
>> +        if (ret) {
>> +            platform_device_put(pdev);
>> +            continue;
> 
> Why is this a continue ? you can get -EINVAL and -EBUSY from 
> device_add_of_node() - can/should you really continue this loop after an 
> -EINVAL ?
> 
> Understood for architected you want to keep going and get the system up 
> at the very least I'd add a noisy message about it.

Yes, that's correct. If we bail out on failure, the system will hang. 
The platform can have more timers which will work allowing the system to 
boot.

It is expected to have the driver probe function to print a message on 
error, so adding one message seems to be redundant.

If timer_probe() fails to initialize a timer (the number of initialized 
driver is zero) then an error will be emitted.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


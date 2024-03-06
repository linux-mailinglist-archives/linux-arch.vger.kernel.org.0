Return-Path: <linux-arch+bounces-2880-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC27874006
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEAB2822EF
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2F13E7D5;
	Wed,  6 Mar 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhn3SYkm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911C13E7CD;
	Wed,  6 Mar 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751437; cv=none; b=Nw9KKhsYlwYx411lawVjCpxDQerV5UWhe7ZA8SOe5Okz72PyGnyxnBbm9V7pWh3QNQaPOvt7RId7hm4RwJRpKJq97uhWmN59gXKIo6j/KGTTrsieQx8+aDELq1OQm4H9/Tky1zdy51Q0IpXcseqJ6MTvRuqGZ3ms4iHCdfgRx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751437; c=relaxed/simple;
	bh=S1B66MxrwVuLPSQFyJ77+48RvxlkmOBerBkBYw8jSEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AALgQLtEpogct7i6fzGuUvobXwRY+r7/eRaDOEqJrAFmkN3YYjU+OmU+tU2hibW+BmelD2G4AA2VxSw22kZRUgaO6CUifC21K+GvQQ0E07w037O7y9SzT8+kNU4WARrW7KebJDH6ptZ+0thExzfTg91cRVUW9gvvOOStvlJIHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhn3SYkm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so22156a12.0;
        Wed, 06 Mar 2024 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709751435; x=1710356235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/3jW2QBDSgBnts4h6tssrFWwv5T7cgyrIwuez/CQaIA=;
        b=lhn3SYkmlFol+BzsdKb7YdazOkLW2PJZzfOdmsR0s/NcAuz/ka7BXETPFfaGqPafjp
         gy+pHbeH9MhOsUo9kJQkY3XtTnTbZJZfA04Hg51u3/8ftwgtwFp5lrkG84LiMDvl42rJ
         lsmxwZk6NAMRbveon8tVoLKgozVisUObUDaIQ5dsPHI5ulFbj3lUloIfkXD9gBelqUx5
         mrgOWKRSVtT3q9hjJCadVP2Ne0a/SGV7EUPsnS6F7ALXvQ6vIBDe5ay21AY9/bwzTRW0
         H5T0GPVgfTeZBTVtnvAyDnN9BqTpZy+NJ8OYyE5GSGzLrzEBxy56Qlw57X28A2NFgM0u
         x00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709751435; x=1710356235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3jW2QBDSgBnts4h6tssrFWwv5T7cgyrIwuez/CQaIA=;
        b=QoN5fRQw+unj9dcBo+phAQgrEAClbih4PRYdxdzklm4TeLQt1Ose3DgAy7pQcCBgUR
         UMQ3X1o7Zq5D8h3q1o1psTzV7v4jOzVFi8wZHzToGp9w6aLG2xFLV1Rw5aocCq2HAMJR
         fC57dsnIhsjAmuLnJ3V8KqtdwOBL5w+wp1FChtsxG+a72QTbZgFy+t9uqa6/hlzwFzBY
         ocwFpirN9WAD8XktKIo7fCCHBK+yHHZObafT8wmS+ml97m+tDv3w3bsVROzwwZ0vmtHo
         UbkdtpkLhnb3APaTHfspTqFtCl7j4wLBee2AANcSM5hFQBjRZHCgIzLF38bh65Tle90P
         G9jg==
X-Forwarded-Encrypted: i=1; AJvYcCXW+dIk5DUg/v5PbvkPN3eZVOABqHPq+uCBT6LgS/G0eh3qyPviJ/BZFzd8vdGYKuNVroPrY+KFdoI/M8+WG3S0d9Z7u+vVaM3nRArv7ZjJheWJlFAMzqU1iO7Li5ufrOH0lYnzUvl9Jg==
X-Gm-Message-State: AOJu0YwPHnz+EXHNM3CDwRoNk8UHpi/idFRTh9XbRv9zNYUFJ9PKvSaf
	ncAkKUrpHmDUeKaeYKes/zqz2ly2EmZmT36LK5UyV3ay0RkToIZz
X-Google-Smtp-Source: AGHT+IGiMoD748cTco9NIrvqXQZ2Af1R1FR7YjTHGXOpN+RqmiZs7H8a2bDhRE+JZP40vUT4bx0L6A==
X-Received: by 2002:a17:90a:6c96:b0:29b:2fc9:197a with SMTP id y22-20020a17090a6c9600b0029b2fc9197amr12405643pjj.21.1709751435228;
        Wed, 06 Mar 2024 10:57:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001d739667fc3sm12881659plg.207.2024.03.06.10.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 10:57:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b0cb0228-2c07-4fec-9943-d8a631d5c9a9@roeck-us.net>
Date: Wed, 6 Mar 2024 10:57:12 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Add support for suppressing warning backtraces
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org
References: <20240305184033.425294-1-linux@roeck-us.net>
 <CAEUSe79fwDAhTdAD3OecCAw=LRzajxA3b-B2r8YtVDPeH7LCtA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAEUSe79fwDAhTdAD3OecCAw=LRzajxA3b-B2r8YtVDPeH7LCtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 3/6/24 10:24, Daniel Díaz wrote:
[ ... ]
> 
> Thank you SO very much for this work! This is very much appreciated!

Thanks a lot for the feedback.

> We run into these warnings at LKFT all the time, and making sure that
> the noise doesn't drown the relevant signal is very important.
> 

Can you send me a list of all the warnings you are seeing ? I do see
lots of warnings when running drm tests in qemu, but I am not sure if
those are caused by emulation problems or if they are expected.
A list of warnings seen on real hardware would help me prepare
additional patches to address (or, rather, suppress) those.

Thanks,
Guenter



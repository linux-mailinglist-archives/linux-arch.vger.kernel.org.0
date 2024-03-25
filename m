Return-Path: <linux-arch+bounces-3173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FE88AF5A
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA102E2805
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECC6AA1;
	Mon, 25 Mar 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KrsZ3Dg+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E221C290;
	Mon, 25 Mar 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393538; cv=none; b=JNG4+w0vDsHhYeqtLJGM3URRTg9lrI7ks4FwDdcxj0vEeZHMs9KK2JuOw9uq2igw8/wme/AP0s0PA1iVYxkY7GdIkE/fQbkDWAmkX887KeiZdamXhwTWSQeMNZMaRK84/SbN4s1lOpu7HbGgbofSUlsUuxRe+onWaIAWQqV5knw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393538; c=relaxed/simple;
	bh=2naQ2zIwUDbAjnJ5fx8ylGGomTwmKBGC8b+4Kf4kgXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKKwoXze11LAMBjxdcLVzxmfnYhIqJTKwRHRZTMtMLs5WArJ/m8wBv1TmosY7rRV2q5rQJ70apWVJoBkZFO5G/ZhrSkPJfdNjmMAdB7sA5OaCQnP/4pFCjYkgu1sZnn0cak1RdkTGJLw81Ezo/syNiCbRXO7Kmmc0C+YDy6LjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KrsZ3Dg+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/cOCj+3wz4G6mk7yJiOWKe+zWsog28msEXqYEYYF/PM=; b=KrsZ3Dg+BwR2PxtUZN7tRdXRM/
	hzD6VT43T4jmCbBOlQa33Sar4qRrk34fr3Gcfdp4NQWyMpNKX4DH6J6albLyamFGb2CGEiZOtE5rW
	nfLSP5bRkADNvscY10NWmVllXMUJQDKsyuMyDODwaUtYaCGTGsGnQon7XaddORjvYOehlVXeE6sfa
	n/bIrGl+ZGAr/bWkdry+5ZKkzUgSzgmqpPyWvxvxDDYmJrN43CkrvCrpPuNbz7XsoF5Y7Liw6IIBe
	NgZRaSze46IWt9cBigdGv5ZmmlmhThf/TXsUVgjI26u4CbbOLSlCdcwSS/EtJiOUe4764vjuRvM+Q
	SpYZMTlA==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ropdK-00FBOo-Kv; Mon, 25 Mar 2024 20:05:23 +0100
Message-ID: <0729b218-53f1-4139-b165-a324794a9abd@igalia.com>
Date: Mon, 25 Mar 2024 16:05:06 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Guenter Roeck <linux@roeck-us.net>, linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>,
 Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-6-linux@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240325175248.1499046-6-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guenter,

On 3/25/24 14:52, Guenter Roeck wrote:
> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> intentionally trigger warning backtraces by providing bad parameters to
> the tested functions. What is tested is the return value, not the existence
> of a warning backtrace. Suppress the backtraces to avoid clogging the
> kernel log.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> - Rebased to v6.9-rc1
> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
> 
>   drivers/gpu/drm/tests/drm_rect_test.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 76332cd2ead8..75614cb4deb5 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -406,22 +406,28 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
>   
>   static void drm_test_rect_calc_hscale(struct kunit *test)
>   {
> +	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	START_SUPPRESSED_WARNING(drm_calc_scale);

I'm not sure if it is not that obvious only to me, but it would be nice
to have a comment here, remembering that we provide bad parameters in
some test cases.

Best Regards,
- Maíra

>   	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	END_SUPPRESSED_WARNING(drm_calc_scale);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
>   
>   static void drm_test_rect_calc_vscale(struct kunit *test)
>   {
> +	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	START_SUPPRESSED_WARNING(drm_calc_scale);
>   	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	END_SUPPRESSED_WARNING(drm_calc_scale);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }


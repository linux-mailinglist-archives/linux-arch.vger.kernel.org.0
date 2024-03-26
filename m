Return-Path: <linux-arch+bounces-3186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99888B6B6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 02:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694A5B2226B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 01:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F291C6B5;
	Tue, 26 Mar 2024 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rhJ7uKz/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDA1C6BB;
	Tue, 26 Mar 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415401; cv=none; b=W/+fx7+/orU6IciVaDvtWHrSg2URj5L76FAI/IH2IUKDSD+35nuXrchzgF80e89NlX7f/YsXaWxc6+z1ZmVCoV3fkT3ltB6fOPIic1BqAm6aVnJk0I9nDydtHjh5zT7K4fYuKzRGwLxMN8YvuiXbKD/gR2qEgiFBwntUK8KsKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415401; c=relaxed/simple;
	bh=roh76JjuCHVUs6BqSKLBhOvR9MjqmcFIpLLx103EMp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0LPK8Mh/FQUXpCybK75iT+Ywt8hKKLbHVIa6vkRj9X2tPMb3BGZdbwUKWkRiFHneT0/ZbiYeaTWIAqa38Gve9FDCZ2QYuEwtWYzG67pNt5leN7uU72B91e8im1hZRagRMRFAtyju0rWAvM56xOE7Z9xNYrTLSnUScZ1ItT5WjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rhJ7uKz/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2+G6lqjrPiGO7sJw8UoeY7bYbprZSC43xVHllYnfJhk=; b=rhJ7uKz/jNbiljxVy2Ig0qkt0g
	kvpuUE1lPLbwPzGEmAlvqhxspbyqAuhp3lvVu2/0lRADtNrnqN1QVyowSfck4x7sswZ3Mf2c+isL5
	JHZn0pHwYrSeW216yn4KsRHK18declY467zYpe1aGEz4NXQ34ztnSOhzbkext8kKJgZdEYIA3CDQl
	MqJkCcu19SKuJctfquerQaSbPbb9T0JPq0vVllSSIHhmlX5nSZbHfYt1w1RnUNz1OMZqjwluyIgKJ
	Z/NwN46y340x2/yIZMUl99PpWvJ+BJHNP4LRLQigoe4+IwdjCfowt9nl3g3oxJgDc06FTbUHhayoY
	+ROL5mmQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rovJx-00FHd6-1x; Tue, 26 Mar 2024 02:09:45 +0100
Message-ID: <7f6a223f-f432-4e1b-a67e-3816448224a1@igalia.com>
Date: Mon, 25 Mar 2024 22:09:31 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>,
 David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>,
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
 <0729b218-53f1-4139-b165-a324794a9abd@igalia.com>
 <e880828b-552e-488e-9f31-3989bec276ae@roeck-us.net>
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
In-Reply-To: <e880828b-552e-488e-9f31-3989bec276ae@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/24 16:24, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Mar 25, 2024 at 04:05:06PM -0300, Maíra Canal wrote:
>> Hi Guenter,
>>
>> On 3/25/24 14:52, Guenter Roeck wrote:
>>> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
>>> intentionally trigger warning backtraces by providing bad parameters to
>>> the tested functions. What is tested is the return value, not the existence
>>> of a warning backtrace. Suppress the backtraces to avoid clogging the
>>> kernel log.
>>>
>>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> - Rebased to v6.9-rc1
>>> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
>>>
>>>    drivers/gpu/drm/tests/drm_rect_test.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
>>> index 76332cd2ead8..75614cb4deb5 100644
>>> --- a/drivers/gpu/drm/tests/drm_rect_test.c
>>> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
>>> @@ -406,22 +406,28 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
>>>    static void drm_test_rect_calc_hscale(struct kunit *test)
>>>    {
>>> +	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
>>>    	const struct drm_rect_scale_case *params = test->param_value;
>>>    	int scaling_factor;
>>> +	START_SUPPRESSED_WARNING(drm_calc_scale);
>>
>> I'm not sure if it is not that obvious only to me, but it would be nice
>> to have a comment here, remembering that we provide bad parameters in
>> some test cases.
> 
> Sure. Something like this ?
> 
>          /*
>           * drm_rect_calc_hscale() generates a warning backtrace whenever bad
>           * parameters are passed to it. This affects all unit tests with an
>           * error code in expected_scaling_factor.
>           */
> 

Yeah, perfect. With that, feel free to add my

Acked-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Thanks,
> Guenter


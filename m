Return-Path: <linux-arch+bounces-5243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27148926DE5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 05:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54CDB21BEC
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02F17BAB;
	Thu,  4 Jul 2024 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moU9omPD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFD175BF;
	Thu,  4 Jul 2024 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062456; cv=none; b=b2PBsV4MqifOPw/+S3VBLiAm+L/GD13XPfff8eidzAN33TRFEZlwLtI3A/ZNypC8rdTL4RPu04AJOL8xpIc9a61dQhGBEoPwD2PE2GHZAXQqCzGybtYa0Iz5MvVXLAr8hl91XlPt5K0tuFaTxOUtP7kQqlXLJfZkbIbNJfxSGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062456; c=relaxed/simple;
	bh=ozVsIz9V8JUmzaycXhNrWIkGuT/FbEsamlyIdaaoFqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gELO/VbTJCy1+InJ8F1iZLP3199VvCch0nUTVrnFZBgbnFUfOCKUi14yGsPn5AjEeBhBslEyD388woWUfFeCVpkMB8YRCyHF60K8/CuC+yUEPpPW2g2zRaUUTPzETjFspG56dweaC2C44efApDFJVSh3UJxtTsO/c+mHQyeEPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moU9omPD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-70df2135426so82142a12.2;
        Wed, 03 Jul 2024 20:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720062454; x=1720667254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycsA2gNz1L+6UNLNvUf817Gyt9X2YXe+eJ8xNRmK7A8=;
        b=moU9omPDe61KMx4KJXsmc7+inJ5Y4/A3M+cheURHFG+pS2fiZCZdbTpcrpqGGm0QTC
         EtJMMfeVSgM70+JoFTvuNFfG84i4zNFos2UCioY2cQrpSbVp2HUWHGct1ZFAy+1o5gjg
         hDhNitlHdMLx4eXf8SlUGkkzUY8ePqjUWbKl2Rm+r7aaTivF1Y3y0c3sExkocNfEkf9n
         /LxN1ENQJGKFDN+f2D8Pt/nPvlX+xZlBaqB/fel/MVvRHnOFl1xn5L2B4hEyH72zAK7o
         Npqo2KvnOIVoAbU2DnTID3t7+qByzkmOm5GVa0LJ6VJCZ6i9iJajpJs0Ecxz0fKvRWVB
         NgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062454; x=1720667254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycsA2gNz1L+6UNLNvUf817Gyt9X2YXe+eJ8xNRmK7A8=;
        b=jGUwptfuuGoqigZZxEoe3Tg4jY6naCdR+y//+IwrTW0tuohm5scCwppKQLXhvNrsFQ
         nIu53We5Sa0em+zxl8lrRH5dOVhxq3jOxu2mK2IuFYPvAbyEMHJNQquNnF49dGBxHuD+
         o0rOF2o8O7y2NuftxHv2ZxlA6OZ/6b/I4nh1GesS6VTTx+ZFUpvh2xB6UenfDM9V4zVZ
         SJL5qIcyFJRG7hvUCr3UY+YZL/lmQ3GCOdwQ7sUwpudOevQuu6+e764eP5Ww6J67QO81
         cjLkD6/iIiZw3fF2wXQVVvrCzCTh48ocw3AU7MgD4U4t53F7slyeewHJ68AmBFV7m7RE
         cREw==
X-Forwarded-Encrypted: i=1; AJvYcCUZFCJm8lhBAQfa/vBF6bqWqND1G2cArxkn68MiEeOZPS+ZwDAqbB/ggQCe1DTKIJAz8t7HCbtyUGS35fd6wpMgsRjNUIma5L85MafBevyD7DMMnZwUh8ngPgz+7vdBcLclUcjDgbkltw==
X-Gm-Message-State: AOJu0Yw/YeqYTDS2EGrT35mImYs+K26jBKeHkZM2OjefVyDI+tmg+9LT
	M4TSR/DxHoMjagDnsshtG+hZ2cTRj4sdG3MYnA9agQOtkNqQfFV4
X-Google-Smtp-Source: AGHT+IHa4SfojXwOPuMOqJE6dz5iI9eVc6jfXwWftN+Knol8EyDs0RHh5hpBGtE9d+/7U32pk/zkTQ==
X-Received: by 2002:a05:6a20:3947:b0:1be:d5e9:b444 with SMTP id adf61e73a8af0-1c0cc66a252mr313260637.0.1720062454412;
        Wed, 03 Jul 2024 20:07:34 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb0e94da7csm27189025ad.50.2024.07.03.20.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:07:34 -0700 (PDT)
Message-ID: <fd9c003a-b1ea-46cf-a6d1-b91b174bcf7b@gmail.com>
Date: Thu, 4 Jul 2024 12:07:32 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH lkmm] docs/memory-barriers.txt: Remove left-over
 references to "CACHE COHERENCY"
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>
 <ZoQFMqkRMDEZdvpa@andrea>
 <00b12ab0-611c-4006-91a3-229062ba2139@paulmck-laptop>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <00b12ab0-611c-4006-91a3-229062ba2139@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Dropping most CCs]

On Tue, 2 Jul 2024 10:35:43 -0700, Paul E. McKenney wrote:
> On Tue, Jul 02, 2024 at 03:48:34PM +0200, Andrea Parri wrote:
>> On Tue, Jul 02, 2024 at 08:42:44PM +0900, Akira Yokosawa wrote:
>>> Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
>>> [smp_]read_barrier_depends()") removed the entire section of "CACHE
>>> COHERENCY", without getting rid of its traces.
>>>
>>> Remove them.
>>>
>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>>> Cc: Will Deacon <will@kernel.org>
>>
>> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Queued for the v6.12 merge window, thank you both!

Paul,

Commit 1b8aad080e48 in the dev tree doesn't have Andrea's Acked-by:

Can you please apply it on next rebase?

        Thanks, Akira

> 
> 							Thanx, Paul


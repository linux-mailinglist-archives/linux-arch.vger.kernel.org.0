Return-Path: <linux-arch+bounces-4452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15BE8C791E
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9E1C21AE2
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C814B978;
	Thu, 16 May 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LetnUTAp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022831E491
	for <linux-arch@vger.kernel.org>; Thu, 16 May 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872615; cv=none; b=jjlLqwLqhMOanvIj5tPV97uzOAsWM6a9yJ29k56DiW97I+0Fau/h5aCZaYOViXYUCoEnnbEVHTRd0pOePeHYCPll/tLwBUqz9pC3w/Irdmt5nwrz5v31UEZpJzufw3t5T00znztF/4CuikTyit2ADns6Uct75+76b3X+ZwN8iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872615; c=relaxed/simple;
	bh=IaLO8A8eOYs5s/2/cuHYZ/9daRCUlFtjjAcRYjoYHbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CerhluSA1skvGpnTKqB4v34VgGbTwgGNj2NGWipehqu/R9wsZ1vCEagC/pi9qYxwVO6o9XOMSy9z4lZLgzsETMkehC0scQlEbVzqc3WW7tW3q9fhIrKSYl47U3aXlOjJM0Z4b0N2ZwKdQH4/16NK/jF4IpJhklETADYJ1CGvFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LetnUTAp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715872613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
	b=LetnUTApS9rOMinRA9PPN1FMqHsQVFOK3UQV1W/gtEN1pacN5tMikYZGHdbDvkpCOTCvm/
	z5WcrdBvVNiUaf1wKWNWw4mg/Uf8qzlmCLr9lHb6NCUgdUFYdvpqX+jj0JGDm2Dul4sAbs
	wKOeBW/oYzi9OQAp9BmAyy4+7D5+laQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-UyAOLU1hMzihgTDRB_2Rww-1; Thu, 16 May 2024 11:16:51 -0400
X-MC-Unique: UyAOLU1hMzihgTDRB_2Rww-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-522362e8317so6224703e87.0
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2024 08:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872610; x=1716477410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
        b=EJVxI3VWMDwEDwVzku1H6SEryGdSvhc5aLnDTfvtr4qVEF2cr4Z3VKrgTfZo17uBWe
         SUDpVBPvQomW6bmnaTqpaNFf7om82/7l1wvibcQFj79Vm+x75/NgCkxGQSJvqYeZYws+
         /cYdBs0yeJ82UZE0i6kPbGDaC0dIY9TYoej5IoyfOft/3hd7PyQbBBb5wzPcjFBU6v2K
         qxKmdfpQLujway9VhNw8Xnzd9XuXxGxsBtBTm2EqaBBFTAm6Veu2HBoMrgepMkDqwNx0
         GmBdWMsWQ1/R2MBHNESeV5I8wPP5YsFsxVZmiI5dvCGg73k//48VgHwoM0VFvV8lUUjj
         8TJA==
X-Forwarded-Encrypted: i=1; AJvYcCVDxlY3a3C6KMDLfFbdsZarzHYe48Xe5+VRgpWg9juDCWKEKcKQ6d50dhuuD4QF0L672vxP8/31wNN8T1ZiPfbqzdOBXG3hn325kw==
X-Gm-Message-State: AOJu0YxdRbcUx4zlJ6tkD63lQzB4hJEFKsKUVl5AgUnJ9u73AvE4LD/K
	vmQyuCFIe8IOGUeudilFPtA96QHOKxzq25G1+nFLb1eP78rEQg0CLMxYc/l6szD4GZ1ksyiKPvw
	zc/jnSiCuH5x3dXN/1AK7/SGIzVlEmEpehX62DrRMZgStgYh2+pPzwmIs2lw=
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656969e87.16.1715872609963;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+FVB1tK34ViV8+agUiDomeCaRnMnSEIgSm4pt/ya2IBcjeS4X3/vaKP4GVA4MVD2ub1n+A==
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656944e87.16.1715872609565;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a60eabd3csm596814866b.108.2024.05.16.08.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Message-ID: <b9a5068c-8760-4f92-8a1b-bd276532109d@redhat.com>
Date: Thu, 16 May 2024 17:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
 <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
 <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 5:11 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 16.05.24 um 17:03 schrieb Hans de Goede:
>> Hi,
>>
>> On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
>>> CC Hans who has been doing the majority of the ACPI video work.
>>>
>>> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>>>> renames the video source files under arch/ such that they does not
>>>> refer to fbdev any longer. The new files named video.o conflict with
>>>> ACPI's video.ko module.
>>> And surely nobody knew or was unable to check upfront that there was a
>>> video.ko already in the kernel.
>> Sorry, but nack for this change. I very deliberately kept the module-name
>> as video when renaming the actual .c file from video.c to acpi_video.c
>> because many people pass drivers/video/acpi_video.c module arguments
>> on the kernel commandline using video.param=val .
>>
>> Try e.g. doing a duckduckgo search for 1 off:
>>
>> "video.only_lcd"
>> "video.allow_duplicates"
>> "video.brightness_switch_enabled"
> 
> Ok, that makes sense. I'll rename the other files.

Great, thank you.

Regards,

Hans




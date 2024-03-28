Return-Path: <linux-arch+bounces-3270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49789890048
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30AE28E8AF
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE48060C;
	Thu, 28 Mar 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nU601w+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NeVwDz/G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nU601w+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NeVwDz/G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F859B4E;
	Thu, 28 Mar 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632787; cv=none; b=kMwHmb+Tlak7mtHE1hU786ZVWR6VzIFDDHEIrQKWmLj6V6R4uX2RK5FaS8SiMBssueF9zgLGw48AIfBPefdRYAfIaNZBOymNDKSn6cumxvMhqK/EZFndiOTSdLR6YOw/WFu+Utq+zaeRGvxsaSGNXJNuGEdPt7u/adTV3BwwAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632787; c=relaxed/simple;
	bh=0VOtzpy98TzNv5BuOB20s1D/nQBFwVg0RHpkpFtpbD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pid6eHE+T5PvMHPfbBewWGCnastnyT2+RQzigFsPLoxl2X1eXuP/AGwLm7Yst1ITYYWzu6LvBxcG8K7N7BiYwU1HoA48XeYbbj3m1WXISkmBtKy1C7ecshbMsvavwhLa08zpJtdDhK0xiTme2rEzh11I/iD35nlADygS1SSa7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nU601w+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NeVwDz/G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nU601w+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NeVwDz/G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FE112096C;
	Thu, 28 Mar 2024 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ij2Otxna5to9v4ar/0Ig3hfIGSPyVYpp2GAwK6pFXjo=;
	b=nU601w+VZiETEH2DUUyN8B+NOXK2DOFjM7pT0QDYAezrSyT2xtDvuWT8dLZJwqU9yxX1YH
	oJA12PF8zSozLVgqHSw3Mrw6rtZ6R//iazl8ybyeAXtE+jwEDZvy/OQ4udp9dmofWXS58h
	de0oa0HRcnsxPQgMV7hdW+6wBTM8a4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ij2Otxna5to9v4ar/0Ig3hfIGSPyVYpp2GAwK6pFXjo=;
	b=NeVwDz/G52UQg/ByogZOv/vscgDN6XzKAszac/EFVBGZ6RUuvX+H46iVtshHhXZtH6Fg/u
	QHZywQcMcz3BSkBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ij2Otxna5to9v4ar/0Ig3hfIGSPyVYpp2GAwK6pFXjo=;
	b=nU601w+VZiETEH2DUUyN8B+NOXK2DOFjM7pT0QDYAezrSyT2xtDvuWT8dLZJwqU9yxX1YH
	oJA12PF8zSozLVgqHSw3Mrw6rtZ6R//iazl8ybyeAXtE+jwEDZvy/OQ4udp9dmofWXS58h
	de0oa0HRcnsxPQgMV7hdW+6wBTM8a4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ij2Otxna5to9v4ar/0Ig3hfIGSPyVYpp2GAwK6pFXjo=;
	b=NeVwDz/G52UQg/ByogZOv/vscgDN6XzKAszac/EFVBGZ6RUuvX+H46iVtshHhXZtH6Fg/u
	QHZywQcMcz3BSkBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C9EE13AF7;
	Thu, 28 Mar 2024 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n0koIIxxBWZ4QAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 28 Mar 2024 13:33:00 +0000
Message-ID: <9db306b2-b102-4bf5-a120-e1d279269fe9@suse.de>
Date: Thu, 28 Mar 2024 14:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arch: Remove struct fb_info from video helpers
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, arnd@arndb.de, javierm@redhat.com,
 sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-3-tzimmermann@suse.de>
 <b5a8bc60-ad16-407d-9e57-c224467c3f06@gmx.de>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <b5a8bc60-ad16-407d-9e57-c224467c3f06@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCPT_COUNT_TWELVE(0.00)[26];
	 FREEMAIL_TO(0.00)[gmx.de,arndb.de,redhat.com,linux.dev];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Hi

Am 28.03.24 um 12:04 schrieb Helge Deller:
> On 3/27/24 21:41, Thomas Zimmermann wrote:
>> The per-architecture video helpers do not depend on struct fb_info
>> or anything else from fbdev. Remove it from the interface and replace
>> fb_is_primary_device() with video_is_primary_device(). The new helper
>
> Since you rename this function, wouldn't something similar to
>
> device_is_primary_display()
>     or
> device_is_primary_console()
>     or
> is_primary_graphics_device()
>     or
> is_primary_display_device()
>
> be a better name?

The video_ prefix is there to signal that the code is part of the video 
subsystem.

But there's too much code that tried to figure out a default video 
device. So I actually have different plans for this function. I'd like 
to replace it with a helper that returns the default device instead of 
just testing for it. Sample code for x86 is already in vgaarb.c. [1] The 
function's name would then be video_default_device() and return the 
appropriate struct device*. video_is_primary device() will be removed. 
This rename here is the easiest step towards the new helper. Ok?

Best regards
Thomas

[1] https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/vgaarb.c#L559

>
> Helge
>
>> is similar in functionality, but can operate on non-fbdev devices.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Andreas Larsson <andreas@gaisler.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> ---
>>   arch/parisc/include/asm/fb.h     |  8 +++++---
>>   arch/parisc/video/fbdev.c        |  9 +++++----
>>   arch/sparc/include/asm/fb.h      |  7 ++++---
>>   arch/sparc/video/fbdev.c         | 17 ++++++++---------
>>   arch/x86/include/asm/fb.h        |  8 +++++---
>>   arch/x86/video/fbdev.c           | 18 +++++++-----------
>>   drivers/video/fbdev/core/fbcon.c |  2 +-
>>   include/asm-generic/fb.h         | 11 ++++++-----
>>   8 files changed, 41 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/fb.h
>> index 658a8a7dc5312..ed2a195a3e762 100644
>> --- a/arch/parisc/include/asm/fb.h
>> +++ b/arch/parisc/include/asm/fb.h
>> @@ -2,11 +2,13 @@
>>   #ifndef _ASM_FB_H_
>>   #define _ASM_FB_H_
>>
>> -struct fb_info;
>> +#include <linux/types.h>
>> +
>> +struct device;
>>
>>   #if defined(CONFIG_STI_CORE)
>> -int fb_is_primary_device(struct fb_info *info);
>> -#define fb_is_primary_device fb_is_primary_device
>> +bool video_is_primary_device(struct device *dev);
>> +#define video_is_primary_device video_is_primary_device
>>   #endif
>>
>>   #include <asm-generic/fb.h>
>> diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
>> index e4f8ac99fc9e0..540fa0c919d59 100644
>> --- a/arch/parisc/video/fbdev.c
>> +++ b/arch/parisc/video/fbdev.c
>> @@ -5,12 +5,13 @@
>>    * Copyright (C) 2001-2002 Thomas Bogendoerfer 
>> <tsbogend@alpha.franken.de>
>>    */
>>
>> -#include <linux/fb.h>
>>   #include <linux/module.h>
>>
>>   #include <video/sticore.h>
>>
>> -int fb_is_primary_device(struct fb_info *info)
>> +#include <asm/fb.h>
>> +
>> +bool video_is_primary_device(struct device *dev)
>>   {
>>       struct sti_struct *sti;
>>
>> @@ -21,6 +22,6 @@ int fb_is_primary_device(struct fb_info *info)
>>           return true;
>>
>>       /* return true if it's the default built-in framebuffer driver */
>> -    return (sti->dev == info->device);
>> +    return (sti->dev == dev);
>>   }
>> -EXPORT_SYMBOL(fb_is_primary_device);
>> +EXPORT_SYMBOL(video_is_primary_device);
>> diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
>> index 24440c0fda490..07f0325d6921c 100644
>> --- a/arch/sparc/include/asm/fb.h
>> +++ b/arch/sparc/include/asm/fb.h
>> @@ -3,10 +3,11 @@
>>   #define _SPARC_FB_H_
>>
>>   #include <linux/io.h>
>> +#include <linux/types.h>
>>
>>   #include <asm/page.h>
>>
>> -struct fb_info;
>> +struct device;
>>
>>   #ifdef CONFIG_SPARC32
>>   static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
>> @@ -18,8 +19,8 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t 
>> prot,
>>   #define pgprot_framebuffer pgprot_framebuffer
>>   #endif
>>
>> -int fb_is_primary_device(struct fb_info *info);
>> -#define fb_is_primary_device fb_is_primary_device
>> +bool video_is_primary_device(struct device *dev);
>> +#define video_is_primary_device video_is_primary_device
>>
>>   static inline void fb_memcpy_fromio(void *to, const volatile void 
>> __iomem *from, size_t n)
>>   {
>> diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
>> index bff66dd1909a4..e46f0499c2774 100644
>> --- a/arch/sparc/video/fbdev.c
>> +++ b/arch/sparc/video/fbdev.c
>> @@ -1,26 +1,25 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>
>>   #include <linux/console.h>
>> -#include <linux/fb.h>
>> +#include <linux/device.h>
>>   #include <linux/module.h>
>>
>> +#include <asm/fb.h>
>>   #include <asm/prom.h>
>>
>> -int fb_is_primary_device(struct fb_info *info)
>> +bool video_is_primary_device(struct device *dev)
>>   {
>> -    struct device *dev = info->device;
>> -    struct device_node *node;
>> +    struct device_node *node = dev->of_node;
>>
>>       if (console_set_on_cmdline)
>> -        return 0;
>> +        return false;
>>
>> -    node = dev->of_node;
>>       if (node && node == of_console_device)
>> -        return 1;
>> +        return true;
>>
>> -    return 0;
>> +    return false;
>>   }
>> -EXPORT_SYMBOL(fb_is_primary_device);
>> +EXPORT_SYMBOL(video_is_primary_device);
>>
>>   MODULE_DESCRIPTION("Sparc fbdev helpers");
>>   MODULE_LICENSE("GPL");
>> diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/fb.h
>> index c3b9582de7efd..999db33792869 100644
>> --- a/arch/x86/include/asm/fb.h
>> +++ b/arch/x86/include/asm/fb.h
>> @@ -2,17 +2,19 @@
>>   #ifndef _ASM_X86_FB_H
>>   #define _ASM_X86_FB_H
>>
>> +#include <linux/types.h>
>> +
>>   #include <asm/page.h>
>>
>> -struct fb_info;
>> +struct device;
>>
>>   pgprot_t pgprot_framebuffer(pgprot_t prot,
>>                   unsigned long vm_start, unsigned long vm_end,
>>                   unsigned long offset);
>>   #define pgprot_framebuffer pgprot_framebuffer
>>
>> -int fb_is_primary_device(struct fb_info *info);
>> -#define fb_is_primary_device fb_is_primary_device
>> +bool video_is_primary_device(struct device *dev);
>> +#define video_is_primary_device video_is_primary_device
>>
>>   #include <asm-generic/fb.h>
>>
>> diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
>> index 1dd6528cc947c..4d87ce8e257fe 100644
>> --- a/arch/x86/video/fbdev.c
>> +++ b/arch/x86/video/fbdev.c
>> @@ -7,7 +7,6 @@
>>    *
>>    */
>>
>> -#include <linux/fb.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/vgaarb.h>
>> @@ -25,20 +24,17 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
>>   }
>>   EXPORT_SYMBOL(pgprot_framebuffer);
>>
>> -int fb_is_primary_device(struct fb_info *info)
>> +bool video_is_primary_device(struct device *dev)
>>   {
>> -    struct device *device = info->device;
>> -    struct pci_dev *pci_dev;
>> +    struct pci_dev *pdev;
>>
>> -    if (!device || !dev_is_pci(device))
>> -        return 0;
>> +    if (!dev_is_pci(dev))
>> +        return false;
>>
>> -    pci_dev = to_pci_dev(device);
>> +    pdev = to_pci_dev(dev);
>>
>> -    if (pci_dev == vga_default_device())
>> -        return 1;
>> -    return 0;
>> +    return (pdev == vga_default_device());
>>   }
>> -EXPORT_SYMBOL(fb_is_primary_device);
>> +EXPORT_SYMBOL(video_is_primary_device);
>>
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/video/fbdev/core/fbcon.c 
>> b/drivers/video/fbdev/core/fbcon.c
>> index 46823c2e2ba12..85c5c8cbc680a 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2939,7 +2939,7 @@ void fbcon_remap_all(struct fb_info *info)
>>   static void fbcon_select_primary(struct fb_info *info)
>>   {
>>       if (!map_override && primary_device == -1 &&
>> -        fb_is_primary_device(info)) {
>> +        video_is_primary_device(info->device)) {
>>           int i;
>>
>>           printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
>> diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
>> index 6ccabb400aa66..4788c1e1c6bc0 100644
>> --- a/include/asm-generic/fb.h
>> +++ b/include/asm-generic/fb.h
>> @@ -10,8 +10,9 @@
>>   #include <linux/io.h>
>>   #include <linux/mm_types.h>
>>   #include <linux/pgtable.h>
>> +#include <linux/types.h>
>>
>> -struct fb_info;
>> +struct device;
>>
>>   #ifndef pgprot_framebuffer
>>   #define pgprot_framebuffer pgprot_framebuffer
>> @@ -23,11 +24,11 @@ static inline pgprot_t 
>> pgprot_framebuffer(pgprot_t prot,
>>   }
>>   #endif
>>
>> -#ifndef fb_is_primary_device
>> -#define fb_is_primary_device fb_is_primary_device
>> -static inline int fb_is_primary_device(struct fb_info *info)
>> +#ifndef video_is_primary_device
>> +#define video_is_primary_device video_is_primary_device
>> +static inline bool video_is_primary_device(struct device *dev)
>>   {
>> -    return 0;
>> +    return false;
>>   }
>>   #endif
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



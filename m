Return-Path: <linux-arch+bounces-3268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA4B890000
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 14:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8751F21856
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D85811E8;
	Thu, 28 Mar 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NGpA6mvg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qbyHkPq/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NY+qt2Vh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4AgHX/b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCE54BCB;
	Thu, 28 Mar 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632120; cv=none; b=rnPtN/52usULYpEJ3sYUDJAbA14sbQ3yC7mnokI6zxGlCsZHZbJM/1xN0B2ueVWikWItTD1kLioYCZ4HQhswIBR7nSv2r8JjVWMP8p6OTi+MZw/KYcwAFaWBtU7++WWIqo4GtkwZlEDkPw8ZD0+cDLsYDep4sbCmh7B0XjxLXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632120; c=relaxed/simple;
	bh=NcfMVdP8jG0B+5gpRT5h6O65Scej8O2oGnAGIFber+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD4xJAcCqvkuvKR5dQ2X5ZkJyYCaC0DZUXqeLF1kN5BtIxeHdX/pugv6XmAveouZdlg46TfA9/Z5TCnxikUecsIZ9/7c9bW5MwYRd925GEGK4YevULFdfekLRTtEKjyBsMKfqjOdnBbjqKNtMmnn1u7/WtNBj3x17KGx73FfvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NGpA6mvg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qbyHkPq/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NY+qt2Vh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4AgHX/b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBED233F29;
	Thu, 28 Mar 2024 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nBV9RrkyQba5NE+tY7TfavXdtDbJlQ91iAXymXIDHBE=;
	b=NGpA6mvg7SFLaMcdkaGNHlk4p5WZfQLCmZYijHyXug8BWvcnMg4XRWGmMu1m+NnOdC6/oC
	jUDkV7nKO3ld0CJ6vYYPtZG6zQsO0ghndq5hj7VZO5H9ndGSF+6C+Jv4zy5f1GP2XU7Iw5
	u0CBN7YO30G0WhadnZ9sTV5sfaFbfRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nBV9RrkyQba5NE+tY7TfavXdtDbJlQ91iAXymXIDHBE=;
	b=qbyHkPq/SEgcwQyQHpo6vxF0xg5dHYOQjze+ICf8/63zx8Mn9W7pDDngyKiNTe8VHCVPUo
	9PaUNAeWEGZ03PCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nBV9RrkyQba5NE+tY7TfavXdtDbJlQ91iAXymXIDHBE=;
	b=NY+qt2VhonCWz3P20U2cBtC00PDuVJUkY1lU9QraJMicGNmHTYKZDAep6Ak0qejrElOJmw
	ljjsKl4gZ/2aPeG9JR3jsAaJgN6AGg8ImUaFNSjipl1Sggupx+9Zx+dXGr0aFH3B0gIIC0
	28Xkvoj58+cjVxxwLR8+1wfXV43tRm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nBV9RrkyQba5NE+tY7TfavXdtDbJlQ91iAXymXIDHBE=;
	b=N4AgHX/br0WdmOd7rgZKyvHTXJi2A3IlhcmW3nOdAH5hh+27AJDHqSmhyc4owM/9a5dw0r
	fcfmhq4WiuAmQ/CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB06813AB3;
	Thu, 28 Mar 2024 13:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3Tx/L/BuBWboPAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 28 Mar 2024 13:21:52 +0000
Message-ID: <c114a614-8e65-42a2-8df6-5a3015e79c29@suse.de>
Date: Thu, 28 Mar 2024 14:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
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
 <20240327204450.14914-2-tzimmermann@suse.de>
 <70aefe08-b4c4-4738-a223-e4b04562cd56@gmx.de>
Content-Language: en-US
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
In-Reply-To: <70aefe08-b4c4-4738-a223-e4b04562cd56@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NY+qt2Vh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="N4AgHX/b"
X-Rspamd-Queue-Id: CBED233F29
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.de,arndb.de,redhat.com,linux.dev];
	URIBL_BLOCKED(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,intel.com:email,davemloft.net:email,gmx.de:email,zytor.com:email,hansenpartnership.com:email,linutronix.de:email,gaisler.com:email,alien8.de:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 28.03.24 um 13:39 schrieb Helge Deller:
> On 3/27/24 21:41, Thomas Zimmermann wrote:
>> Various Kconfig options selected the per-architecture helpers for
>> fbdev. But none of the contained code depends on fbdev. Standardize
>> on CONFIG_VIDEO, which will allow to add more general helpers for
>> video functionality.
>>
>> CONFIG_VIDEO protects each architecture's video/ directory.
>
> Your patch in general looks good.
> But is renaming the config option from CONFIG_FB_CORE to CONFIG_VIDEO
> the best choice?
> CONFIG_VIDEO might be mixed up with multimedia/video-streaming.
>
> Why not e.g. CONFIG_GRAPHICS_CORE?
> I'm fine with CONFIG_VIDEO as well, but if someone has a better idea
> we maybe should go with that instead now?

We already have CONFIG_VIDEO in drivers/video/Kconfig specifically for 
such low-level graphics code. For generic multimedia, we could have 
CONFIG_MEDIA, CONFIG_STREAMING, etc. rather than renaming an established 
Kconfig symbol.

Best regards
Thomas

>
> Helge
>
>> This
>> allows for the use of more fine-grained control for each directory's
>> files, such as the use of CONFIG_STI_CORE on parisc.
>>
>> v2:
>> - sparc: rebased onto Makefile changes
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
>>   arch/parisc/Makefile      | 2 +-
>>   arch/sparc/Makefile       | 4 ++--
>>   arch/sparc/video/Makefile | 2 +-
>>   arch/x86/Makefile         | 2 +-
>>   arch/x86/video/Makefile   | 3 ++-
>>   5 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index 316f84f1d15c8..21b8166a68839 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -119,7 +119,7 @@ export LIBGCC
>>
>>   libs-y    += arch/parisc/lib/ $(LIBGCC)
>>
>> -drivers-y += arch/parisc/video/
>> +drivers-$(CONFIG_VIDEO) += arch/parisc/video/
>>
>>   boot    := arch/parisc/boot
>>
>> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
>> index 2a03daa68f285..757451c3ea1df 100644
>> --- a/arch/sparc/Makefile
>> +++ b/arch/sparc/Makefile
>> @@ -59,8 +59,8 @@ endif
>>   libs-y                 += arch/sparc/prom/
>>   libs-y                 += arch/sparc/lib/
>>
>> -drivers-$(CONFIG_PM) += arch/sparc/power/
>> -drivers-$(CONFIG_FB_CORE) += arch/sparc/video/
>> +drivers-$(CONFIG_PM)    += arch/sparc/power/
>> +drivers-$(CONFIG_VIDEO) += arch/sparc/video/
>>
>>   boot := arch/sparc/boot
>>
>> diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
>> index d4d83f1702c61..9dd82880a027a 100644
>> --- a/arch/sparc/video/Makefile
>> +++ b/arch/sparc/video/Makefile
>> @@ -1,3 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>
>> -obj-$(CONFIG_FB_CORE) += fbdev.o
>> +obj-y    += fbdev.o
>> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>> index 15a5f4f2ff0aa..c0ea612c62ebe 100644
>> --- a/arch/x86/Makefile
>> +++ b/arch/x86/Makefile
>> @@ -265,7 +265,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
>>   # suspend and hibernation support
>>   drivers-$(CONFIG_PM) += arch/x86/power/
>>
>> -drivers-$(CONFIG_FB_CORE) += arch/x86/video/
>> +drivers-$(CONFIG_VIDEO) += arch/x86/video/
>>
>>   ####
>>   # boot loader support. Several targets are kept for legacy purposes
>> diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
>> index 5ebe48752ffc4..9dd82880a027a 100644
>> --- a/arch/x86/video/Makefile
>> +++ b/arch/x86/video/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> -obj-$(CONFIG_FB_CORE)        += fbdev.o
>> +
>> +obj-y    += fbdev.o
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



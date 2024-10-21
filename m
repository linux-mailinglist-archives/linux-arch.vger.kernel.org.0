Return-Path: <linux-arch+bounces-8336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4199A65A3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D571F23E2E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3F1E571E;
	Mon, 21 Oct 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sky3yooi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HTpNCtRV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sky3yooi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HTpNCtRV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884C1E25E3;
	Mon, 21 Oct 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508322; cv=none; b=NkTtnVoiJN4h//urLc1rMgyifhVKrzwG1e5aPgu+bE0gO17EkO512LgcM7dpoN0M95ADWEOUOJe+X8jYPFTcrTOjGanCH+pefAnj8AqA+uwWeTRYPCz9K22G6sdFTwApWdaO8k7gg4mdfQVUj8TFa1EgeM5Uwxf7EvIh4Nu4//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508322; c=relaxed/simple;
	bh=Sc2DVuRGcnxAdq5yOlajYBFosbVzYoKWRwSe7XRAG3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3e79906zjDwg/GqQnBPOOtUW+i/j1sYS+W7tkHQiLa1Dhv9mRMTHRKuxAmS0z7WKZ3ASWNNqnwhD7Rc1aZJO+6X6L1SSOFiC8W8T6Z85oPO8YcMluI0NjZMvgWgG1YpefTr+LVFkCgFc9z8iqSg6QWAqXp1wG3jHSX8mExsFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sky3yooi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HTpNCtRV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sky3yooi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HTpNCtRV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 270431FC04;
	Mon, 21 Oct 2024 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729508318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2uxdBA13vMIyxe5igUJesTE6g/+Q8UD52ks2NuJBT8=;
	b=sky3yooix9pei98sjqsbnb9VhFMHsFiYNYrfdc0oBXeNx8hkpKvMDzCstDdDQUtCAig1YP
	OH8i1xU9gPJ1dUlR+f/Mtg8pNy9IgNAuvGnV8XlPFfCCpbU49zDLqkxsydYAVtvdaG49cd
	+HoJgnbC8immIaBGrFdmacVvbBRa7jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729508318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2uxdBA13vMIyxe5igUJesTE6g/+Q8UD52ks2NuJBT8=;
	b=HTpNCtRVeJesYMVqdNnLNRVCkJQiB/mxFNMCpvRYP7C351KhEscxJLQmVL/Q/JkR1c5uZa
	PGb17uIM7/7+6UAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729508318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2uxdBA13vMIyxe5igUJesTE6g/+Q8UD52ks2NuJBT8=;
	b=sky3yooix9pei98sjqsbnb9VhFMHsFiYNYrfdc0oBXeNx8hkpKvMDzCstDdDQUtCAig1YP
	OH8i1xU9gPJ1dUlR+f/Mtg8pNy9IgNAuvGnV8XlPFfCCpbU49zDLqkxsydYAVtvdaG49cd
	+HoJgnbC8immIaBGrFdmacVvbBRa7jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729508318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2uxdBA13vMIyxe5igUJesTE6g/+Q8UD52ks2NuJBT8=;
	b=HTpNCtRVeJesYMVqdNnLNRVCkJQiB/mxFNMCpvRYP7C351KhEscxJLQmVL/Q/JkR1c5uZa
	PGb17uIM7/7+6UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6476A136DC;
	Mon, 21 Oct 2024 10:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a1/OFt0zFmf6EgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 21 Oct 2024 10:58:37 +0000
Message-ID: <aa679655-290e-4d19-9195-1a581431b9e6@suse.de>
Date: Mon, 21 Oct 2024 12:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] drm: handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@arndb.de>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
 <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
 <a25086c4-e2fc-4ffc-bc20-afa50e560d96@app.fastmail.com>
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
In-Reply-To: <a25086c4-e2fc-4ffc-bc20-afa50e560d96@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_TO(0.00)[arndb.de,linux.ibm.com,quicinc.com,holtmann.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,redhat.com,intel.com,linuxfoundation.org,orcam.me.uk];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLykjg6e7ifkwtw7jmpw7b9yio)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi

Am 21.10.24 um 12:08 schrieb Arnd Bergmann:
> On Mon, Oct 21, 2024, at 07:52, Thomas Zimmermann wrote:
>> Am 08.10.24 um 14:39 schrieb Niklas Schnelle:
> d 100644
>>> --- a/drivers/gpu/drm/qxl/Kconfig
>>> +++ b/drivers/gpu/drm/qxl/Kconfig
>>> @@ -2,6 +2,7 @@
>>>    config DRM_QXL
>>>    	tristate "QXL virtual GPU"
>>>    	depends on DRM && PCI && MMU
>>> +	depends on HAS_IOPORT
>> Is there a difference between this style (multiple 'depends on') and the
>> one used for gma500 (&& && &&)?
> No, it's the same. Doing it in one line is mainly useful
> if you have some '||' as well.
>
>>> @@ -105,7 +106,9 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>>>    
>>>    		writeb(val, bochs->mmio + offset);
>>>    	} else {
>>> +#ifdef CONFIG_HAS_IOPORT
>>>    		outb(val, ioport);
>>> +#endif
>> Could you provide empty defines for the out() interfaces at the top of
>> the file?
> That no longer works since there are now __compiletime_error()
> versions of these funcitons. However we can do it more nicely like:
>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 9b337f948434..034af6e32200 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -112,14 +112,12 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
>   		return;
>   
> -	if (bochs->mmio) {
> +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
>   		int offset = ioport - 0x3c0 + 0x400;
>   
>   		writeb(val, bochs->mmio + offset);
>   	} else {
> -#ifdef CONFIG_HAS_IOPORT
>   		outb(val, ioport);
> -#endif
>   	}

For all functions with such a pattern, could we use:

bool bochs_uses_mmio(bochs)
{
     return !IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio
}

void writeb_func()
{
     if (bochs_uses_mmio()) {
       writeb()
#if CONFIG_HAS_IOPORT
     } else {
       outb()
#endif
     }
}

u8 readb_func()
{
     u8 ret = 0xff
     if (bochs_uses_mmio()) {
       ret = readb()
#if CONFIG_HAS_IOPORT
     } else {
       ret = inb()
#endif
     }
     return ret;
}

?

The code in bochs_uses_mmio() could then also print a drm_warn_once if 
we have neither MMIO nor I/O ports.

I'd review a separate series for such a change.

>   }
>   
> @@ -128,16 +126,12 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
>   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
>   		return 0xff;
>   
> -	if (bochs->mmio) {
> +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
>   		int offset = ioport - 0x3c0 + 0x400;
>   
>   		return readb(bochs->mmio + offset);
>   	} else {
> -#ifdef CONFIG_HAS_IOPORT
>   		return inb(ioport);
> -#else
> -		return 0xff;
> -#endif
>   	}
>   }
>   
> @@ -145,32 +139,26 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
>   {
>   	u16 ret = 0;
>   
> -	if (bochs->mmio) {
> +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
>   		int offset = 0x500 + (reg << 1);
>   
>   		ret = readw(bochs->mmio + offset);
>   	} else {
> -#ifdef CONFIG_HAS_IOPORT
>   		outw(reg, VBE_DISPI_IOPORT_INDEX);
>   		ret = inw(VBE_DISPI_IOPORT_DATA);
> -#else
> -		ret = 0xffff;
> -#endif
>   	}
>   	return ret;
>   }
>   
>   static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
>   {
> -	if (bochs->mmio) {
> +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
>   		int offset = 0x500 + (reg << 1);
>   
>   		writew(val, bochs->mmio + offset);
>   	} else {
> -#ifdef CONFIG_HAS_IOPORT
>   		outw(reg, VBE_DISPI_IOPORT_INDEX);
>   		outw(val, VBE_DISPI_IOPORT_DATA);
> -#endif
>   	}
>   }
>   
>> And the in() interfaces could be defined to 0xff[ff].
>>
>> I assume that you don't want to provide such empty macros in the
>> kernel's io.h header?
> That was the original idea many years ago, but Linus rejected
> my pull request for it, so Niklas worked through all drivers
> individually to add the dependencies instead.

I see.

Best regards
Thomas

>
>       Arnd

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



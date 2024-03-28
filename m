Return-Path: <linux-arch+bounces-3269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9A890024
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9700292F16
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C580618;
	Thu, 28 Mar 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H/ff7VMO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j6883XZz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oVwe4PFK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E0FhyfcQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F97F47E;
	Thu, 28 Mar 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632239; cv=none; b=Z8PUZ+ti/5y7ZH2S6BkNfAcRUpUv1VRJfZjQGuThTPsvi7RwcBfgl/3nS/A+r85K4T7eCJLvhpgZyaARbxHP6UmbPY1mJPPkNNMxHqVwaaqN+PajuMlpLRNcOPu2AH7k1LP2PXYFj316pbnew3QEqmp+r+RHyvQ4XS5yOO7QQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632239; c=relaxed/simple;
	bh=F+0ob8mSRMkc9wp2iIVPxGNBC6XsW+nz8IpJEy5tcjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OisI3FD2DxTnJzRHCNR4Eq3FY9XvhL6eFgfijK7EGb4btrnTZ2jE0cgrtycfjst9o4bPYIcPqSlkMg0FfGdbxTC4rIeTyL6NE0AUVzugJUeSOd5xIPtpPxw2G+mpi+vzTBk973wM2wCOrVyuoOmaiClM6vk2kPFiXNz4lqHX1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H/ff7VMO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j6883XZz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oVwe4PFK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E0FhyfcQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F7422626;
	Thu, 28 Mar 2024 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cE1HJS/wRX1Dncixs5UhBGJAhu6OL2KkpGFOlWlnWwc=;
	b=H/ff7VMOhTmfzHQDt2gnhAp2O7Ob3fyb+XnYBmkUiKIrQoNY3fQTSwDJk9Mnab2m6I7XEp
	KAEIeFBhrCBzMgxskZjr7A6CdqtyUHYhl0Cohot6y9Q3i7ATKWxrrbqO3gKY0ouL0XyXPi
	eCjhjytEdnhVTSs6lbemsB9TAbirJyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cE1HJS/wRX1Dncixs5UhBGJAhu6OL2KkpGFOlWlnWwc=;
	b=j6883XZzoLCy4fWQOTkExtkwAxZ6/jC9LZAOEHb+yX/s1YhCIBgNQJrP5IzFx1I8dZino2
	oAMbzwybhUxdVHAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cE1HJS/wRX1Dncixs5UhBGJAhu6OL2KkpGFOlWlnWwc=;
	b=oVwe4PFKz3oA91pJDphmG3JYHmiW4SgPyPSCPnmFaBJNK6U5Hcfpemosdl4LFIddl1j2wf
	KYe2KFt/W6Yj8MKKaRr8YA/YeDWF7uVLxKbEZMY/9MrstmW3DmOCJWmq1S7MMi7wwdByRt
	TQSRsrSEwAJewK3oy8tPv8abhBpmD3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cE1HJS/wRX1Dncixs5UhBGJAhu6OL2KkpGFOlWlnWwc=;
	b=E0FhyfcQHxSu5FP1E4GVSRJaaIZNlqOQ4yIze1jmLX70dval50fE+i0DfMIfcPbMxVsFa6
	qtin3UKgWKuF3NBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F4313AB3;
	Thu, 28 Mar 2024 13:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xgboKmpvBWavPQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 28 Mar 2024 13:23:54 +0000
Message-ID: <dbea9119-58c3-42b4-a50b-7438f4c04385@suse.de>
Date: Thu, 28 Mar 2024 14:23:54 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arch: Rename fbdev header and source files
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>, sui.jingfeng@linux.dev
Cc: Linux-Arch <linux-arch@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-4-tzimmermann@suse.de>
 <140d6bb3-5f44-49cb-846b-7141e551eedd@gmx.de>
 <72e8aa58-c732-4a96-bcb1-32310ee041b3@app.fastmail.com>
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
In-Reply-To: <72e8aa58-c732-4a96-bcb1-32310ee041b3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -7.25
X-Spamd-Result: default: False [-7.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-1.96)[94.83%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 RCPT_COUNT_TWELVE(0.00)[38];
	 FREEMAIL_TO(0.00)[arndb.de,gmx.de,redhat.com,linux.dev];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.ozlabs.org,lists.linux-m68k.org,lists.linux.dev,lists.infradead.org,kernel.org,arm.com,xen0n.name,linux-m68k.org,alpha.franken.de,HansenPartnership.com,ellerman.id.au,gmail.com,users.sourceforge.jp,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi

Am 28.03.24 um 13:51 schrieb Arnd Bergmann:
> On Thu, Mar 28, 2024, at 13:46, Helge Deller wrote:
>> On 3/27/24 21:41, Thomas Zimmermann wrote:
>>> +++ b/arch/arc/include/asm/video.h
>>> @@ -0,0 +1,8 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef _ASM_VIDEO_H_
>>> +#define _ASM_VIDEO_H_
>>> +
>>> +#include <asm-generic/video.h>
>>> +
>>> +#endif /* _ASM_VIDEO_H_ */
>> I wonder, since that file simply #includes the generic version,
>> wasn't there a possibility that kbuild could symlink
>> the generic version for us?
>> Does it need to be mandatory in include/asm-generic/Kbuild ?
>> Same applies to a few other files below.
> It should be enough to just remove the files entirely,
> as kbuild will generate the same wrappers for mandatory files.

If that works, I'm happy to remove these wrapper files.

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



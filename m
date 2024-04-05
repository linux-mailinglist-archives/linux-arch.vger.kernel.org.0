Return-Path: <linux-arch+bounces-3459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22D8998F1
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623372807AC
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05074146594;
	Fri,  5 Apr 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NTHIOwZ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KToj6Ik8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NTHIOwZ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KToj6Ik8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B317721;
	Fri,  5 Apr 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307869; cv=none; b=giC8/D86pp78vwztcvEKYVq/bieXqxL1/GdigGj9CFoRCPR253CA3s8kEzXKEVeq3hUGvqUAJUnO9992sl6gGrrK4Bb5RTauIKJ5xbOxOYUqV8pjZ9Zoehj67PZaYFOS5oo1VLetCncRklUDJGMWCvSi1rh5AThxYRI/WgfH9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307869; c=relaxed/simple;
	bh=CZ7sdleduXPFl026NflXweEHKoQ3VxVB/rZ/gonnO14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRXfKaoUj3UdX3Xh7cexJkp/mGWvubYXAtk0rCmfvq51aSRxEXIvdvec8NF5ZpWam9sLbfvCu4z+U3g3c0v3xn5mAcGiRy44TCZS5z7miPFvrt7O8Ww4KwN2PbmZkFIiMawtoUEBJUys4j8PKEiVpTpy8qs/0hVL8o7WMBEngO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NTHIOwZ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KToj6Ik8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NTHIOwZ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KToj6Ik8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1491D1F78A;
	Fri,  5 Apr 2024 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712307866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q6m7RkFG+I05tVEKqU5D+NUntnuekF2Z+soqECDuzWU=;
	b=NTHIOwZ+L3b2OUEsvJLD8ClmWEK1V9PGjFmF3hXDlTtwirb0F7vborCm2hzx0SiFnjhbIv
	zzjmLpjtndDKGRKFQdcMcew0yVU0osvQibX+CHvUnAA8pJZGyIsXDp0AdfGiyaEVYugdhw
	ZyfnpyppmEFhkJ8JcRJr91khwROWpFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712307866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q6m7RkFG+I05tVEKqU5D+NUntnuekF2Z+soqECDuzWU=;
	b=KToj6Ik8dGLGisbepSgkxn4mN2+dzr6QWAUlbfj7teTNyD0Xb003EKLmDQCOQOFBFeFQjI
	d81wCJIrvTO/D4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NTHIOwZ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KToj6Ik8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712307866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q6m7RkFG+I05tVEKqU5D+NUntnuekF2Z+soqECDuzWU=;
	b=NTHIOwZ+L3b2OUEsvJLD8ClmWEK1V9PGjFmF3hXDlTtwirb0F7vborCm2hzx0SiFnjhbIv
	zzjmLpjtndDKGRKFQdcMcew0yVU0osvQibX+CHvUnAA8pJZGyIsXDp0AdfGiyaEVYugdhw
	ZyfnpyppmEFhkJ8JcRJr91khwROWpFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712307866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q6m7RkFG+I05tVEKqU5D+NUntnuekF2Z+soqECDuzWU=;
	b=KToj6Ik8dGLGisbepSgkxn4mN2+dzr6QWAUlbfj7teTNyD0Xb003EKLmDQCOQOFBFeFQjI
	d81wCJIrvTO/D4Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 98D09139F1;
	Fri,  5 Apr 2024 09:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LEQAJJm+D2ZoTwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 05 Apr 2024 09:04:25 +0000
Message-ID: <c281bb8e-0719-4b28-a637-56615ad16913@suse.de>
Date: Fri, 5 Apr 2024 11:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arch: Remove fbdev dependency from video helpers
To: arnd@arndb.de, sam@ravnborg.org, javierm@redhat.com, deller@gmx.de,
 sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240329203450.7824-1-tzimmermann@suse.de>
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
In-Reply-To: <20240329203450.7824-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -5.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1491D1F78A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,ravnborg.org,redhat.com,gmx.de,linux.dev];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim]

Hi,

if there are no further comments, can this series be merged through 
asm-generic?

Best regards
Thomas

Am 29.03.24 um 21:32 schrieb Thomas Zimmermann:
> Make architecture helpers for display functionality depend on general
> video functionality instead of fbdev. This avoids the dependency on
> fbdev and makes the functionality available for non-fbdev code.
>
> Patch 1 replaces the variety of Kconfig options that control the
> Makefiles with CONFIG_VIDEO. More fine-grained control of the build
> can then be done within each video/ directory; see parisc for an
> example.
>
> Patch 2 replaces fb_is_primary_device() with video_is_primary_device(),
> which has no dependencies on fbdev. The implementation remains identical
> on all affected platforms. There's one minor change in fbcon, which is
> the only caller of fb_is_primary_device().
>
> Patch 3 renames the source and header files from fbdev to video.
>
> v3:
> - arc, arm, arm64, sh, um: generate asm/video.h (Sam, Helge, Arnd)
> - fix typos (Sam)
> v2:
> - improve cover letter
> - rebase onto v6.9-rc1
>
> Thomas Zimmermann (3):
>    arch: Select fbdev helpers with CONFIG_VIDEO
>    arch: Remove struct fb_info from video helpers
>    arch: Rename fbdev header and source files
>
>   arch/arc/include/asm/fb.h                    |  8 ------
>   arch/arm/include/asm/fb.h                    |  6 -----
>   arch/arm64/include/asm/fb.h                  | 10 --------
>   arch/loongarch/include/asm/{fb.h => video.h} |  8 +++---
>   arch/m68k/include/asm/{fb.h => video.h}      |  8 +++---
>   arch/mips/include/asm/{fb.h => video.h}      | 12 ++++-----
>   arch/parisc/Makefile                         |  2 +-
>   arch/parisc/include/asm/fb.h                 | 14 -----------
>   arch/parisc/include/asm/video.h              | 16 ++++++++++++
>   arch/parisc/video/Makefile                   |  2 +-
>   arch/parisc/video/{fbdev.c => video-sti.c}   |  9 ++++---
>   arch/powerpc/include/asm/{fb.h => video.h}   |  8 +++---
>   arch/powerpc/kernel/pci-common.c             |  2 +-
>   arch/sh/include/asm/fb.h                     |  7 ------
>   arch/sparc/Makefile                          |  4 +--
>   arch/sparc/include/asm/{fb.h => video.h}     | 15 +++++------
>   arch/sparc/video/Makefile                    |  2 +-
>   arch/sparc/video/fbdev.c                     | 26 --------------------
>   arch/sparc/video/video.c                     | 25 +++++++++++++++++++
>   arch/um/include/asm/Kbuild                   |  2 +-
>   arch/x86/Makefile                            |  2 +-
>   arch/x86/include/asm/fb.h                    | 19 --------------
>   arch/x86/include/asm/video.h                 | 21 ++++++++++++++++
>   arch/x86/video/Makefile                      |  3 ++-
>   arch/x86/video/{fbdev.c => video.c}          | 21 +++++++---------
>   drivers/video/fbdev/core/fbcon.c             |  2 +-
>   include/asm-generic/Kbuild                   |  2 +-
>   include/asm-generic/{fb.h => video.h}        | 17 +++++++------
>   include/linux/fb.h                           |  2 +-
>   29 files changed, 124 insertions(+), 151 deletions(-)
>   delete mode 100644 arch/arc/include/asm/fb.h
>   delete mode 100644 arch/arm/include/asm/fb.h
>   delete mode 100644 arch/arm64/include/asm/fb.h
>   rename arch/loongarch/include/asm/{fb.h => video.h} (86%)
>   rename arch/m68k/include/asm/{fb.h => video.h} (86%)
>   rename arch/mips/include/asm/{fb.h => video.h} (76%)
>   delete mode 100644 arch/parisc/include/asm/fb.h
>   create mode 100644 arch/parisc/include/asm/video.h
>   rename arch/parisc/video/{fbdev.c => video-sti.c} (78%)
>   rename arch/powerpc/include/asm/{fb.h => video.h} (76%)
>   delete mode 100644 arch/sh/include/asm/fb.h
>   rename arch/sparc/include/asm/{fb.h => video.h} (75%)
>   delete mode 100644 arch/sparc/video/fbdev.c
>   create mode 100644 arch/sparc/video/video.c
>   delete mode 100644 arch/x86/include/asm/fb.h
>   create mode 100644 arch/x86/include/asm/video.h
>   rename arch/x86/video/{fbdev.c => video.c} (66%)
>   rename include/asm-generic/{fb.h => video.h} (89%)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



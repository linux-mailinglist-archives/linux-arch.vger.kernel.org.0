Return-Path: <linux-arch+bounces-412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A007C7F5517
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 00:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01BA1C20AD7
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A112B7E;
	Wed, 22 Nov 2023 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQVY5WeW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097CBD40;
	Wed, 22 Nov 2023 15:57:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso363064b3a.3;
        Wed, 22 Nov 2023 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700697456; x=1701302256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+jlG3ds7B/4ooT5+OaZJfN0QhswGFhGAyZ2Rsu9K2s=;
        b=YQVY5WeW3H/IfC1vurc4tnaS41vh3bnMMb51mwHb8+xcM5aWYXLnxnu3d7GW7WmEt2
         LBnRQ5x9w4woA71+gajj28RsofI4xfhhMS3dmXxwWAJbZo+2c2m+UjIUzNiJ5lefwebB
         KfwbbCzur//k2GG7jaZySMIwTfwTc2VdJFr/dGAPjcd7tmCpFfI3QG5Txno8664JM2UL
         C7dywLhkRFJbTamrhqvp/d6OhqvAT8KGdFcQJ0+Mpr13CXzedIT7ZEroEACarFGxLzKB
         w/lINhZGMnrX+Rv1KlKhuAyfSCg9nxGWhg7FPIBuZZnWA2YjJUzhQGTUmFJHNuNibil9
         EMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697456; x=1701302256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+jlG3ds7B/4ooT5+OaZJfN0QhswGFhGAyZ2Rsu9K2s=;
        b=R0T7Hg7mWFoKwgNQa9VA/vgXpL14YZLPG70kPyh0T/30w+DGLyYiZq34bZD0+379D0
         RA2D237yEzpbyjp4k+w+AvAaGjq9HB829QXsI2nnUj0EB9kwmoBoe3VGr6jIEdCrtEr4
         8uXlM/p0+7L5Yqy1ONps062jOqTetE8Wdx3ODe8h++wfWLkHI4TcnPoJ1jaPT6cn770X
         uJOr4ELAbo17nedQ142ZsfqjDp5Q7lVOTO0PSfU1z/Jjz1WnBAS/oVdOEUJGlZXL71pG
         MJqVEydEkjMLGLyj38LENDMh4Ps/EmVGWkRhv6+7jYtyIVOsG04v4PR/Vwo0A6/ANNkY
         NAOg==
X-Gm-Message-State: AOJu0Yy+1K4FT+MVJBtyAnPxYotSk+lGOkg5vg1s2j7FVRQJhfJDOFDB
	FzoOV8N8h0irmnGQOW9JXv/8Zokzgw4pdY5W7qU=
X-Google-Smtp-Source: AGHT+IEcrkxFaV05/k48bltiBzPDjaB9G3mYL0yAe+z18ZeBjySI66lMRSulhdaPgjn2fkQqxdAiCin42kBA/Qk4OVs=
X-Received: by 2002:a05:6a00:1302:b0:6c2:cb4a:73c3 with SMTP id
 j2-20020a056a00130200b006c2cb4a73c3mr4379466pfu.11.1700697456419; Wed, 22 Nov
 2023 15:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
In-Reply-To: <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Wed, 22 Nov 2023 17:57:00 -0600
Message-ID: <CAEZ6=UPDPyJ=gq7U50scPM7CUSc8mutJoTodeN6fPdd1YzzxVA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org, minchan@kernel.org, dave.hansen@linux.intel.com, 
	x86@kernel.org, Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com, 
	ying.huang@intel.com, dan.j.williams@intel.com, hezhongkun.hzk@bytedance.com, 
	fvdl@google.com, surenb@google.com, rientjes@google.com, hannes@cmpxchg.org, 
	mhocko@suse.com, Hasan.Maruf@amd.com, jgroves@micron.com, 
	ravis.opensrc@micron.com, sthanneeru@micron.com, emirakhur@micron.com, 
	vtavarespetr@micron.com, Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 3:39=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> I'm having deja vu.  Not 10 minutes ago, Gregory sent out a patchset
> which does the same thing.
>
> https://lkml.kernel.org/r/20231122211200.31620-1-gregory.price@memverge.c=
om
>

Certainly, it appears that we were addressing the same matter but
approaching it from different perspectives or discussions.
And we hastened to submit our RFCs before the Thanksgiving break. :-)

The patch I sent originated from the thread, and the subsequent
discussion commenced with the 'pidfd_set_mempolicy' RFC, possibly
influenced by the 'process_madvise.'
Specifically, the concept of a 'process_mbind()' syscall was suggested
by Frank van der Linden (Google):
https://lkml.kernel.org/linux-mm/Y0WEbCqJHjnqsg8n@dhcp22.suse.cz/T/#m950f26=
bdd6ce494b20ba170cc1f6db85e1924e8e

I would appreciate it if others could kindly evaluate what appears to
be the suitable course of action moving forward.

Thank you!


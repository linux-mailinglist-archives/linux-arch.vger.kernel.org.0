Return-Path: <linux-arch+bounces-2654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A410085EAFF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 22:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F0A1C211B9
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1517127B45;
	Wed, 21 Feb 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="twlEEf1y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E97CF03
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550773; cv=none; b=DFsXopsL6QzN431/ZmvMQNvVuX2nxHGiWKitH92Nzp5mXMZim2yYf/DxIdOszyIz4jWXhRr3yAhwQoYD92QV2RXRIUR3NFdkJGjSfiKVLOFp6whZikExImFXGsl1IKtbY9a8TxOjNVzxFtWfZ1z8eKez3dXRWXGOy5KPeo6Ahko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550773; c=relaxed/simple;
	bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpHjlrdPm9C2xt5ASgwStSAtfeTXiTlAppUeb9zYyJhc+i+FJESn6sWThLSd77mkQQrGDE5x8UD3jvVnqJbMbRNrKFjMEqB4wgkcIF9AOl+AhUJo3ociulTqImtzf8jxfdkejJ6/EDKekBbSyrTjiA4g7LzTAA6Kx0oIqprIDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=twlEEf1y; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c15dd2a1fdso2682682b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550770; x=1709155570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=twlEEf1yUUSQY4M7jcQpxVobd+dWC5ezggwrEwNE60AZ8QeMObLxP14XTPx38VQ2eQ
         TyrB4dnaVh7ipn13+vKwt6sJKS491Skg4KAMlL9NyxSI8HytAsFXSzZSk+umh+bpebcW
         YHwErdKYko8+z7QnDr0g9jOg0w3y7Juvk+0CXSSikE8fwrDLZhKCz4YDBKFAX8UfBeYy
         jUTHfw76ke8UM5rMB3x0u8xRuKsnecR7d8tvj0OaUwXWM9ceEuSwr94Fi6j2NKkbOyG0
         vuocKoz75fJUtkV5Hsf7vnXoE01wfziYx61d427gMjkLIq2cHgMjI++ZqF99CfNbPmnQ
         VnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550770; x=1709155570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=InT8qoYLMUj7QmXlEqZJw5obrmYn+Itdy2194pEZHntFmf/FkIao/q+ZO10eLOiTUe
         0yj3Qk50TLaWlaStexx8lbrT3B/0QovkzvK5RUp+bPmcRxpTeQqDROBjo31PgUQGKoQW
         ZiKMBulY3wtPkqHduqOzyvphD2atWz9LDHfZvbG1ythYs2guLMz+AjF8qtroZOU+Td+1
         jLiu5KOivtoskTGmD8LwRD8iQzNQ1QQXUc/wfqvD2bq6wojp2hLdNro2CyD6RCbQXDTh
         OKaWd7A2Ych/eCNAarFT+al8edw+1ZcSem2NMJRdqvLfNWgSyC4tFsy50VvOTP/iWU/o
         4nCw==
X-Forwarded-Encrypted: i=1; AJvYcCXxXZMW/rLlWhGOyeYki4hSXRY7tbK0rl3gGqECCfDrvMD14fhhE5p697i4bKSXzf76GjwtRFx0HrK2cBSqey0WPmoXLPXi7Tk1rQ==
X-Gm-Message-State: AOJu0YxaMhy8hD1DW5zHYGXcD1J5tjjwG0LgeuuRX/FE9xvIhkyYND8T
	aGZBcf6SVosxRWMvOueD43gKd2PdM+CjRDHyhPVPdwLrywBJSOG6EgNyRhSVBAevzF8hFKQJaF5
	ZOLvVo+l8oXM4HcOqUKkg6SgtEI2aY1BWS4SFQA==
X-Google-Smtp-Source: AGHT+IFZSNXNYlAy0AiXEzXx4upknBW0nGNBljw/bbiwmtTqAeSgHzhF6z+ApQTHTR9DUqPj2ju2fMwMSbPw53G4Luo=
X-Received: by 2002:a05:6808:1208:b0:3c0:3d12:2002 with SMTP id
 a8-20020a056808120800b003c03d122002mr24802049oil.13.1708550769929; Wed, 21
 Feb 2024 13:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
In-Reply-To: <20240221194052.927623-7-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:25:33 -0500
Message-ID: <CA+CK2bDX7v8+NHi2ioxQ4KF+vBYA0JhR3=Sj6ZxBS0jD7i2Gmw@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
>
> Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


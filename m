Return-Path: <linux-arch+bounces-4510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF538CDDC8
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 01:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DF1C21540
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06036AD2C;
	Thu, 23 May 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LV+YjtPX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A8127E17
	for <linux-arch@vger.kernel.org>; Thu, 23 May 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508159; cv=none; b=CAlJqdDuFa4XapNiH7LggPp+JMNr7XPHSdHgeTrcwB2+y8Pl+ya2PzxiZ54CmwC+x6jvPOQDr8vuSmuA8NjuGGage1Vgge9UslqrGJh0xWdEic4MQ6hX+5YaStfkgGrcFv+r6L+kL7dqHlL2soGwRi0+RtnkIytQ2Uc96tOjQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508159; c=relaxed/simple;
	bh=f14zzgUE4RpNE/ENjRASf+ipA6iu8BQvstQoxLsQmxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1R/6nw7fWJMaj97pDbwHmE8WbXVpCz/mfp6UoYT0Dwj/qwU6fbMX67x/W/8aURyI8IQczSOCgNCOFd8naDRiO3enN7/6RvhONWDj+/9jqUCYo1dLQbXQaQWKPVB/XLl8fxaQS7NPPfwHadGceIsSTiZEsR/nXvy5s9QtgN4OEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LV+YjtPX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso187344b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 23 May 2024 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716508158; x=1717112958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIS3HZKU6NCDT1trnq/4hta3P9vI5FJKrJfEbB/tpM=;
        b=LV+YjtPXgbb/L6ClgB/41htWhjJnbTlRAmiQFSMeqTLVDL8EAARikLt0zG3BIgk4VX
         2Ch2TVOEvJ7+POR+Z7hX3kGMhehXVr31wKhy4eNBGYpfIixbkTrAbRZsnnkJzYQ2MYLH
         8EuiglEYSUJi4qTs310q3tKATEZISAhYiJ0NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508158; x=1717112958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uIS3HZKU6NCDT1trnq/4hta3P9vI5FJKrJfEbB/tpM=;
        b=vGlV/JUFlgqXfDwwVqwtCgld70eGFoJC+Yko6KKeIrOqj6zxiPCsVjJth2LSV6d/Eq
         AP9LV/d7Tlnncw/To/RSOXYLgOz5TgluRH6XmJrWqHtcIpQESItx4m2ATPizQri5QMBl
         mJJS2jvJ6BWwzCDhoNl5O7LdzVOsonGs61gOcZcxw/vfS4Qpg+YDM436ai9dMrKMGtoG
         D2RxG8f9K7hX1S0GQ86rnrPwLUZ1aBvie5agaIiEKaRgTQsMiaQ53NVpdjURGJ/Uaz2F
         nHY4Eanu2ic4zCfmmMFzBLKw2jVQfFcYDBA1ckTeDvSwSYDP17oYcxYEOO7bSO5ABJp1
         8AMA==
X-Forwarded-Encrypted: i=1; AJvYcCWhvxZbubD5t5NPynWi2HZxYI8y0AMLU26giceKw8tE3QfmMqHZLvvY+vsRZfbSVg5CBegmz4D1czsDuPqzDlaSvZf+YBW5WWa/gg==
X-Gm-Message-State: AOJu0YzwkimJSYcWjinvHlig47T+HuDN7Elti9X6XIq0/f/QdjPamBR8
	iKKdvQHmlRWU5FSUPoPmZ2DqmUYbwk0szsBMsRqDvKZB6SBH/zuzdEAE1igXnw==
X-Google-Smtp-Source: AGHT+IF9gMMldiKXPn103xSNzm5h3lWwxxnQr7d6oU1kzXIcMvbxWqKETvebkWBqarV+LQyRu7xdMQ==
X-Received: by 2002:a05:6a21:6da1:b0:1af:f50f:cbe5 with SMTP id adf61e73a8af0-1b205c8ad56mr5421013637.8.1716508157798;
        Thu, 23 May 2024 16:49:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274bbbddsm107706a12.92.2024.05.23.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:49:17 -0700 (PDT)
Date: Thu, 23 May 2024 16:49:16 -0700
From: Kees Cook <keescook@chromium.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: mattst88@gmail.com, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <202405231647.69CAA404D8@keescook>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <20240521184652.1875074-1-glaubitz@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521184652.1875074-1-glaubitz@physik.fu-berlin.de>

On Tue, May 21, 2024 at 08:46:52PM +0200, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> Replacing the calls to raw_smp_processor_id() in __warn() with just "0" fixes the problem for me:
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8bff183d6180..12f6cea6b8b0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -671,11 +671,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>         if (file)
>                 pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
> -                       raw_smp_processor_id(), current->pid, file, line,
> +                       0, current->pid, file, line,
>                         caller);
>         else
>                 pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
> -                       raw_smp_processor_id(), current->pid, caller);
> +                       0, current->pid, caller);
>  
>  #pragma GCC diagnostic push
>  #ifndef __clang__
> 
> So, I assume the problem is that SMP support is not fully initialized at this
> point yet such that raw_smp_processor_id() causes the zero pointer dereference.

But how does the commit change that? It called __warn() before too.

Is this an inlining bug?

-- 
Kees Cook


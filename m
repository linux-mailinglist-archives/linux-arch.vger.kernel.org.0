Return-Path: <linux-arch+bounces-12557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B759DAF7E44
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED1C480ED1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A6259CA8;
	Thu,  3 Jul 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KnwLr/Ls"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910F18DB29
	for <linux-arch@vger.kernel.org>; Thu,  3 Jul 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561879; cv=none; b=cVCJMl1dA1OQCMp+l+lKPKKjtuccCfkcy9b677blmcyMlSal/W22Zx/mAOV2QdURtCgcAugL9Gage/vfwEaIzShik/D9kvxerkDlHliAlE31XtSTfrJicQRSeK+AcVDUZxZtt+L8GvDNMahEYew3aCcBb5xLae1ZVVss1NrJ4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561879; c=relaxed/simple;
	bh=F2cRwTeL5Q02MUSGx0I7upITT+Oj9nP6G9v3ZnYL8d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvs/uFKX4bcvJSW23cP9VU+xZjunW8GKulK1kyuPH16nzuBo6f7hEiz7F7TiY+PjgJgxEw8XPylKIySfjLSJz/NVGR6A6DAImhTkcbRhV6j2hXrFKjyRtSQ7BftqDSUA131iutGAd207F1QIqTvQIVgpYNT1lUYeyl6E/w7K0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KnwLr/Ls; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so124200a12.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Jul 2025 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751561875; x=1752166675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPbWJ5gECIxcFGRGN+7adOfD7zhRX4GszEmCOYZfHT0=;
        b=KnwLr/LsNUolyvDinrwhQB+usO5dGsNN9tJU0LQIpONhFKyMM7Ma/58lVc0nlvZHPg
         8wBxj7tt0Sbbxu3/rWS+bLtGqx7byDBi9Y/1fRHJ5/qkIy9DDamKo1yWSE6ehpQBXXlj
         aZIaPo36SnTEc0DBcYBRt1d1AMfsmdR9ySq0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561875; x=1752166675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPbWJ5gECIxcFGRGN+7adOfD7zhRX4GszEmCOYZfHT0=;
        b=XXcYMAiRK/znSOKi3Mpl4Aybj5E55kDfqTUDeaiPRst4k+gHN1krHuoCWvENgnHOTZ
         kcFJjOu4Ksx/TW2mzCx07z7LCkiuxTJa/Qf4olook2kIcT7fRz7bWsPqwa59+IPoGTuP
         0D79+D56RUueu21i7IDR2kVcMODsWdlBUiYzZ3KS4jXBWa8r/oE82LKNoaGZS8y80l+n
         BmgAlfmB9qgMRodHzwDSVcj3HCyor6cSlF4wkUJ5gDEmClTp1B/Lr9lqc0cuzXK/OQg4
         Ss/33cdx7ZWy/9Cc6RWnQRVqX6/l1/rkN9xioza7qGJQg9caRtOlzwo0GIMX/ZWZA1HF
         WIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKYIv3aZUDLg5AwEYDw7wtXU3WXYci8z8PSoioV+759oPiMLBTzzKO9bk7NaCJlbc0Bbd8Cti5Vz0@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpuGF3LP9e2LaWstj4pnl23/6Dpz6ZYfarFgHYmwUCDTGHXTw
	Mst/xEaXQPeXUhWGdhvwO7WycrPvK7EfRLHg7SMtGFAvnTHbLYG1xqqRVAxrkHBjK5kdBH1FFei
	uS5CBgDPdxQ==
X-Gm-Gg: ASbGncs6oxO5boyWTdLxXaL6RmKPb55j2KQ5C673lPNO4iXbqDBaSCOpWpvefhYaVGb
	5msjc1zqh1OH/HKYf+BAk9D9zFKKhp1Wfhbfes/Xmk4Ugg6bdbtXa4w4XFMyYFFKYlBCEyUmM1D
	lcJd7KRvv+T9nQkX36Zn6v+y1nqjqo0bUpUzVfjBglkeEPRTVZT7F63+lEYG7hfk2S2gQktyZnS
	4ELMOshZRsmRHicCVpT3Xk5/UorZp0EpeIz62srsJMPx3mETKjla81vMO8qviUKUYgymLCOtaHe
	Ez3yv30RmcZNQis0p9TJojVE6a41M+WE6ViXRAJOglaftY+F8kJQ2XBYMFfpPjgk7DHMP14wPNc
	UuwoGKveDlQj3MUMtvFWkOUetCa3zyByoZiRq
X-Google-Smtp-Source: AGHT+IEwE6LsfOZpObYsCrR2wSm0R0cGkQ/rkvAsb7omFXbiqnx7EqFgjQTS/I6K4xhPNdwvQ2sDwQ==
X-Received: by 2002:a17:907:60d3:b0:ae3:6659:180b with SMTP id a640c23a62f3a-ae3c2c4b6c7mr902879466b.29.1751561875198;
        Thu, 03 Jul 2025 09:57:55 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e6f67sm7521566b.9.2025.07.03.09.57.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 09:57:54 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade5b8aab41so20897766b.0
        for <linux-arch@vger.kernel.org>; Thu, 03 Jul 2025 09:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0T6BODY7zJguprwukS2VNBT1nGusywXVech4iN6+6QspQLXjrCcdObANnIDzZQ/oJGjIGaaegRd5I@vger.kernel.org
X-Received: by 2002:a17:907:7f05:b0:ae0:dfa5:3520 with SMTP id
 a640c23a62f3a-ae3c2c53817mr841638166b.31.1751561873784; Thu, 03 Jul 2025
 09:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703115222.2d7c8cd5@batman.local.home>
In-Reply-To: <20250703115222.2d7c8cd5@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Jul 2025 09:57:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
X-Gm-Features: Ac12FXx0_b_6E6Blsv0QKfQcWy3HLbRStARf9mJgYWm5joFulPTlFaOEYVysL7s
Message-ID: <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 08:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Remove the prompt to pick DYNAMIC_FTRACE and simply enable it if the
> architecture supports it.

I don't disagree with removing pointless Kconfig options, but if we do
this, we should do it properly.

Because now we have that entirely pointless "HAVE_DYNAMIC_FTRACE*" set
of config options. Which with this patch would be just stupid and
extra indirection that makes things harder to see.

IOW, with this patch we'd have

 (a) architectures that support dynamic ftrace will do

        select HAVE_DYNAMIC_FTRACE
        select HAVE_DYNAMIC_FTRACE_WITH_REGS

     (or whatever combination)

and then

 (b) kernel/trace/Kconfig will just turn that into the proper
DYNAMIC_FTRACE_xyz macros

and when this no longer involves any questions, there is absolutely
*zero* reason I can see for that pointless indirection through another
config variables.

Yes, yes, there's still the "depends on FUNCTION_TRACER" that
technically is a "reason" for that indirection, but it seems to be a
reall ybad one.

IOW, I think that if we do this, we should just get rid of the
"HAVE_DYNAMIC_FTRACE{_XYZ}" config variables entirely, and just make
architectures say

        select DYNAMIC_FTRACE if FUNCTION_TRACER

because the "HAVE_xyz" config variables seem to add no actual value,
only confusion.

Or am I missing some reason for still having that extra config
variable indirection?

             Linus


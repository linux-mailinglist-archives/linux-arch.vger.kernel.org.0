Return-Path: <linux-arch+bounces-1854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8593D8428AA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422FD28E9A3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F398612C;
	Tue, 30 Jan 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYc6cIiw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2FEAC7;
	Tue, 30 Jan 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630578; cv=none; b=lMX/YvalXOtLn7PdmH+FnYEL5UXIsnkJKZkKbb5UsMlHzg7aCz0X29Oyqb2DyoZnd0VlNex8XBJTSlXC0lzuYvTAt5XrcCCPwaz/zPc2YjFZO6n6IsYWooYv2F17dF+kpcOUia0A3Aksc1XYDETMTW7eWDkHuy4nszwNZXUR5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630578; c=relaxed/simple;
	bh=a1sq8uMpLqioihsAs/WblvrrWbPyap3BtOIg52F6Dwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYiWfo+JS7dqTBJwYY0IGI16N2f9DR+/AiDe+Rr6PuQD3RU2zxGlx7cKk5mdAxIwxkB8inK8IQ2qbaPSZAEHFjPiKU7eANeFVVUHqXyiwww9yONRFP2Ea9Io98fqhKiEzRf9eyLLukAr2WJER4cO2uyPpVNWdxch7aqyL3WRbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYc6cIiw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3458802f8f.2;
        Tue, 30 Jan 2024 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706630575; x=1707235375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0g/NXgRqLI2SOKy7+C46GziQ7aYr7hsa14DTOG9qGQ=;
        b=eYc6cIiw/ElSBjJ9B3uaqYtrZHVRkPUET5ygjh49clYOF5nUmHNT0Wa8OZVEIxrZzb
         Z2K2MWg02kymAoTbhiVvUL/zeDOc/atkA6vhmzsEgZv2Hzjvl0ZEx9uDHNKdJrFMOtvj
         WM4nfby17p2V9Kqk40S1oCIaCO9NLaEIA2Sxg/NsWhMXssn8Lh0MwF9r4Mqtw1wrOLqT
         y5+5WeMeZoByTE9dAhbd+ioudZ+7nXZHhidyZJZQdSJRtAG4rjKlw7qASCNZaSYUiryN
         519PlKuMoOBbMkWB3VdFAdq51BxChcFGndEnLiCM/nZvgIrGEWIrD7YDnzOcl+r3N/rs
         nz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630575; x=1707235375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0g/NXgRqLI2SOKy7+C46GziQ7aYr7hsa14DTOG9qGQ=;
        b=MmDJdWMHgYqYZTB65tb3t2+OE76qusWuqYiPS3PGUWIyAotFEaG2RvtRmpptfWxkCA
         KBUXG+2eLq+aLVEz1xQtCrbtENHoRCLcHlGPhQPoTINb2/ttJR4liz7qPM9FoiPsqula
         PTu2wCl4agvaCwpDkP5sTmMhG5+5MdTumPhFvnlPOGvXu4M7Xj0298ILqxLEluNaYhkI
         NL2gEI7TX+5MLeidcD8y8ONRBO3xIo1rfzL80/H3TCsUc8LuhneUxPPkGYj/eqxff99n
         8cELuV+pjMvGN2wSxWgr58t+b4htLIiqWRYt0Zpt8ENFnlFDq+MFYBpU7impeGgBb+l2
         JJgA==
X-Gm-Message-State: AOJu0YxIsLnn7bRv1n00dgeoYrz1TkSbnf3WuGAZ3uNMGNq6NCisaPNP
	Zuo1zBKGqK3dX7XnmeO9ZrTycC3sHWdJs2lgO7NUw/6lSVp8EEDn
X-Google-Smtp-Source: AGHT+IEpEYtdtyVoRZd2f1IVCvvy5P1CxtacvDKsIjxhYiO0MrqDz0G/pF5tDH01v/qC1m4sxwsEbg==
X-Received: by 2002:adf:f84b:0:b0:33a:fd5d:ae40 with SMTP id d11-20020adff84b000000b0033afd5dae40mr1135701wrq.25.1706630574522;
        Tue, 30 Jan 2024 08:02:54 -0800 (PST)
Received: from andrea (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ce6-20020a5d5e06000000b0033af3a43e91sm4465378wrb.46.2024.01.30.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:02:54 -0800 (PST)
Date: Tue, 30 Jan 2024 17:02:49 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"E."@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Paul@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH doc] Emphasize that failed atomic operations give no
 ordering
Message-ID: <ZbkdqYFlFOdcZ63m@andrea>
References: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>

On Tue, Jan 30, 2024 at 06:53:38AM -0800, Paul E. McKenney wrote:
> The ORDERING section of Documentation/atomic_t.txt can easily be read as
> saying that conditional atomic RMW operations that fail are ordered when
> those operations have the _acquire() or _release() prefixes.  This is

s/prefixes/suffixes


> not the case, therefore update this section to make it clear that failed
> conditional atomic RMW operations provide no ordering.
> 
> Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

You may want to add a "subsystem" to the subject line, git-log suggests
"Documentation/atomic_t".  Anyway,

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


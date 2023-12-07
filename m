Return-Path: <linux-arch+bounces-748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFB808B56
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 16:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272FBB20C69
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E2744387;
	Thu,  7 Dec 2023 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egdvm1du"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324911AD;
	Thu,  7 Dec 2023 07:04:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so927030a12.1;
        Thu, 07 Dec 2023 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701961451; x=1702566251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5knuLR3hM6+9ZriPn9ZfBxLpEJULe7zgg0r8B9LwBQ=;
        b=egdvm1duQ5tReHHJzNPEU4eMC48Fj6r9Ttj/feZwBDAxSoB+UC+rN9hmT3D3hCgu0T
         XuT0m19pTrUM4BT0r9HUhEqLkjV4qvyghJ7+JbQn8o7F+hL+upbeOpp2z8yhXxFItZxn
         FAz0TZQHk+Ko3hk3v/U9Pvppa6AuZspRhbvJOnD01Twbv2Wie8zpnMAt7tgCZBixaUFO
         w5hNUfmYgYOybFPJ8eizV6Nt53f1E2vWN+NpbAbA5U5TAEcEeuCHsa3jLYvAMp34VgX+
         gmPimQXYPuRw/w9H4K684w+b0YT+a/oJOxEzOGmK8NrD/NHqOMOLumcWeMnjsoh1Gfe6
         bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961451; x=1702566251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5knuLR3hM6+9ZriPn9ZfBxLpEJULe7zgg0r8B9LwBQ=;
        b=r0/UIFEv/pYZFbEnFhO9W+6UAKGzQGTXh6rZHrfHIR1armj7u1wwUHngB96z3HKxGH
         bqCuv4P5/NzVKIonm2PA04Fi640xfpLaWwKiKIaFd3M7gOcdUAxNl7xAw73K0ucc/3iG
         HSDcZQA2McrR48Gts5jD1V867zUUqki/tjUiJT/wad8IQIbtzNqvu4ul7dAqVZWGvx1n
         1IvbQzvxsd/XPuaydgo2uoq/IpZdOOZiJLtP/Scsr4vBo7sN7k5K90sNEADZVon1fmn5
         t/xPGlEqSya8W3TKcwG5eFl1h2rzwTWjJqCqz+13PLXwrx62+MiauPctoKdep6UsrELK
         8coQ==
X-Gm-Message-State: AOJu0YzNCTfoeuwczG3n5uql4fT9mABGZ6X2F5IDvqFHpSc5j4N/Qc6N
	VHbw3qYYyIVBxBEGBkS35A==
X-Google-Smtp-Source: AGHT+IFzPn+Tpl0Dqjf9pYisVW6PQ3UPQIxV3FhkfzAPQYNjlrEhYEQunjqGN+M9/uWTk8nn3EcnPQ==
X-Received: by 2002:a17:906:1cd3:b0:a1d:7178:161d with SMTP id i19-20020a1709061cd300b00a1d7178161dmr1829704ejh.23.1701961451493;
        Thu, 07 Dec 2023 07:04:11 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709066b0100b00a1d511c5c48sm926885ejr.152.2023.12.07.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:04:11 -0800 (PST)
Date: Thu, 7 Dec 2023 18:04:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <bb7fdb53-6917-44aa-8118-a8b357583c50@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <87edfzavof.fsf@oldenburg.str.redhat.com>
 <202312061308.630C56CCA@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312061308.630C56CCA@keescook>

On Wed, Dec 06, 2023 at 01:09:01PM -0800, Kees Cook wrote:
> On Wed, Dec 06, 2023 at 10:05:36PM +0100, Florian Weimer wrote:
> > * Kees Cook:
> > 
> > > On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> > >> Report available page shifts in arch independent manner, so that
> > >> userspace developers won't have to parse /proc/cpuinfo hunting
> > >> for arch specific strings:
> > >> 
> > >> Note!
> > >> 
> > >> This is strictly for userspace, if some page size is shutdown due
> > >> to kernel command line option or CPU bug workaround, than is must not
> > >> be reported in aux vector!
> > >
> > > Given Florian in CC, I assume this is something glibc would like to be
> > > using? Please mention this in the commit log.
> > 
> > Nope, I just wrote a random drive-by comment on the first version.
> 
> Ah, okay. Then Alexey, who do you expect to be the consumer of this new
> AT value?

libhugetlbfs and everyone who is using 2 MiB pages.

New code should look like this:

	#ifndef AT_PAGE_SHIFT_MASK
	#define AT_PAGE_SHIFT_MASK 29
	#endif
	unsigned long val = getauxval(AT_PAGE_SHIFT_MASK);
	if (val) {
		g_page_size_2mib = val & (1UL << 21);
		return;
	}
	// old 2 MiB page detection code

It is few lines of fast code before code they're already using.


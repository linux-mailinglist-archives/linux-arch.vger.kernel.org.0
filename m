Return-Path: <linux-arch+bounces-12139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A476FAC8253
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7285F4E13D0
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F53230D1E;
	Thu, 29 May 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="PN2Ob3W2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49A1DB924
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544645; cv=none; b=T2ReNoPxY3OrXkD7hlEyV5SPwzGFNzSo+EKiEueDSe+WrHZ9ZIQKGA4C9dMSliY0yAZmLPC1u73j5KI5iFx9iyXRmDNSmBhlek/bP0p3ENyD0lXMReKTIRE0e0G+Pfix4VgO90Z/WjvXZulQoeuMFfyPI11rSHoItaM3i2WndwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544645; c=relaxed/simple;
	bh=wca2f04yGSNetikYQNq4fZhabQgWlYOojnVD8BcpKdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVCBSjR670pDzCmVRNpeX6uo64BdtMt2MKe1ddI5EPXnZxXilpAGeMDCTkBObAmN/GmIjTyHQ2BVgeaH062o2+E5YzIyDbqT+cUxjzLcJvvlYooMV4k3N83t/c4Kra0pNZflDyRJGMT8Dirl4vmofsNmyIGQD26O2NijPmRRvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=PN2Ob3W2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32a6083ef65so11518081fa.2
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1748544641; x=1749149441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZR+bV/RpEv69QT29h8o3+icO6BNVEjRkOnd0TqgTeg=;
        b=PN2Ob3W269WV9lE5hwiaOHucANKYmYvgncgsi7P/AAMb+Zd9m/tLBDLqYzF2pABmSv
         TuOOon5OSbfLNwT3SE4arJhXnofJL9mqq1CXnvvVQKIiyi5SsW8qKx3HYxilQkF1gA3i
         7PTmZ7qLP+TeLyxC/qge7TaVP9oOpOkK8HlaVAMY1A9nyPM1dLNveaOX8UWNB8e662cQ
         sIhznuFtfse4c81pCj7Zj5PowvQSXD6asRk/DtT2F7Wo16w/ktw5qIFb1AFvvg1gptya
         ap4ZAjyZCzcQtoe7uTqfbSxAZ9S/ay4BWYuKTQbB8C1Bw10D/1HMuPiqGN4yUUucJUuu
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748544641; x=1749149441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZR+bV/RpEv69QT29h8o3+icO6BNVEjRkOnd0TqgTeg=;
        b=RiY3y3zSBxKpb1v60n5uthgEK3fueOxJ4R3TUAH36V6hwIFSkNENnytmIy6a0GWr7e
         Z5AwJWK+u3M9Aa35lfTkBSSvmn3KHjVFvq5VTdnu2j11M4FIBd6/xKfpIe0m+KoyDxFw
         +zvLof0ywSGGBQhJnNPeqhbksIrjoYA0eQq3xyuD0nWgWKMXDUOPlIMGJ71imTQjSRFn
         +Mh2UPN0OmOhX2omLfd6pDOmHBerP11agkWbGliXDifdCxSWZJMJM5MKCdt+bDPylWRh
         YshDeir5ndfBjb5puSyzY8GAKttN5SY60CGiaLh9QH8D9CNREk8cStGF+I0Ar6m28pro
         qgRA==
X-Forwarded-Encrypted: i=1; AJvYcCXR1OA+Xe6uG4MO4VcIQHk9Z/Xe3FfQY5aXO/ii+gzkTPQ8/CeoBZYNpytn0iNWJU9IMaWrJOsHfHex@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYvv9/KzLBtiF4hypZ+P8BSDO8hBcmgB/dFugCMJfqLXq9waS
	m++JDAWD+8jL+bS4v5sK+kVZiAPRorKJZTNrSt2atklhohKETy2LdkREZk1hw9SR8jD5N/jJrio
	Rq9X4gg99GSR2exfYZuxV4E9Wr66/zyTtYeEu4dfk
X-Gm-Gg: ASbGnctgIC6p/D4Y6/i08J5tTyk0plBZjBWJwkg/8iXBs+JDOyTenF9wRXXYSGlCOxq
	/vtde9xB3sk8hlq+YnNzNUb6m6FnT+l6rSSCaJRCXrZGEruMk9EFJlSH7D7OLP51Cf3mB79sKYE
	9bLZ0MgT6qkt103vRGEVwsg1qYPpXnkgT4y+QcfplVpQ==
X-Google-Smtp-Source: AGHT+IHvzZNFmorgbMvPjPmVBKaNoD8JL8vbWNjA3kvxqIbWCqlAQjdL2EaLHdbNkYIonfwMKxJEVmqVJFx1wvfSHiQ=
X-Received: by 2002:a05:651c:3050:b0:32a:8631:c41b with SMTP id
 38308e7fff4ca-32a8ce7ff5cmr3131261fa.40.1748544641324; Thu, 29 May 2025
 11:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
In-Reply-To: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 May 2025 11:50:29 -0700
X-Gm-Features: AX0GCFspfSh1KbGnhihvv0QMDvvSEVkz0UOx1CDZtHwOavk_KVICQNzB6RwmT6E
Message-ID: <CALCETrUdgn=eXiGR4pH+EdCGb69bw7n21goJGQbt6mNh0mhTmw@mail.gmail.com>
Subject: Re: [DISCUSSION] proposed mctl() API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The behaviour will be tailored to each action taken.
>
> To begin with, I propose a single flag:
>
> - MCTL_SET_DEFAULT_EXEC - Persists this behaviour across fork/exec.

It's hard to comment without a more complete proposal (*what* behavior
is persisted?), but off the top of my head, this isn't so great.

First, the name means nothing to me.  What's "default exec"?  Even
aside from that, why are fork and exec the same flag?

Beyond this, persisting anything across exec is a giant can of worms.
We have PR_SET_NO_NEW_PRIVS to make it less hazardous, but, in
general, it's risky and potentially quite confusing to do anything
that affects exec'd processes.

Oh, and this whole scheme is also potentially nasty for a different
reason: it's not thread safe.  If one thread wants to spawn a process,
it should not interfere with another thread doing something else.  So
making an mm flag that persists across close can interfere a bit, and
persisting it across clone + exec is even gnarlier.

For any of these, there should be matching query features -- CRIU,
debugging, etc should not be an afterthought.


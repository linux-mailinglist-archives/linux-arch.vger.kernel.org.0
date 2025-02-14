Return-Path: <linux-arch+bounces-10146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A271A3585D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF1516E5B3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9B223339;
	Fri, 14 Feb 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiBctNvG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E576221DAD;
	Fri, 14 Feb 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520146; cv=none; b=FRyYBCtxpeJqePpxOAcfiWWfyJuMe3Od+JR5lwOD1W4Mw8wbw8NE80a7V51zmiwTctnVdXz/R+CNvIGKhjcuLOkjYSuVdDehHVLiWyh8nlwQObHs2ouf3u+gZrTqkJWWCMsFVXt8UjozDvBYF7sKjvhYUf5MJLc27cdkdGVq6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520146; c=relaxed/simple;
	bh=NXofEpxj/9BReHNdZrAdtQGdBJV0QeI1ab2HRy+vlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnn+x/1icgNabkylFbnoAhBUbPxdoFZE2Bz8l3ehN/ENI/uBD471JT9rlrTFXjOkGfvgMXxOov4dvsHZLw+mt0L9s7+NGOi67B2kZdN/tCUrmsqqsgy0gYu7IAPSophXJAi7GUf5+3zbvyrSVRQvuc7lepAS7SwuvuGi3wmxcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiBctNvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DC5C4CEE7;
	Fri, 14 Feb 2025 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520145;
	bh=NXofEpxj/9BReHNdZrAdtQGdBJV0QeI1ab2HRy+vlKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UiBctNvGxngfvE2JzjUfP55+4m+b6irjSMk9DhD2WjG7rAXwoFQMh6nswQtYzXo23
	 DfEyYPVcEGzrZS7Nopp2Jt2V+DK4FvzGM1Fx+VXcanHXwJEy+zUkgEiaOU25g6Umbk
	 BHW8HgAyY//SLDqtR5gs4AWGqCz6ftuayhlF9yC/qQuuA253jlyGRG74U6j+pns9s+
	 c7MgpvEJCDZxllssoKn0pU7WXoJ68RF6SvNjaYC4UZnrPJVSjJ7EJvZ4Bku/+L2iCz
	 uHPaho3QABExPKGI4iHyparvucgjzM4dEnvrShhCJJocntj9r6reJSeoni3UV6e6Ea
	 z4LGlX1mrNzQQ==
Date: Fri, 14 Feb 2025 09:02:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFCv2 0/5]Implement kernel-doc in Python
Message-ID: <20250214090221.2cba05c7@foz.lan>
In-Reply-To: <6958d7a5-2403-423d-a0a3-0c43931a7d30@infradead.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
	<6958d7a5-2403-423d-a0a3-0c43931a7d30@infradead.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 13 Feb 2025 19:15:28 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Hi Mauro,
> 
> 
> On 2/13/25 4:06 AM, Mauro Carvalho Chehab wrote:
> > Hi Jon,
> > 
> > That's the second version of the Python kernel-doc tool.
> > 
> > As the previous version, I tried to stay as close as possible of the original
> > Perl implementation, as it helps to double check if each function was 
> > properly translated to Python.  This have been helpful debugging troubles
> > that happened during the conversion.  
> 
> Since this new version is supposed to be bug-for-bug compatible,

Yes, that's the goal: I'm checking all discrepancies by hand to ensure that
the output net result will be identical at the final version - maybe
except for blank lines/whitespace (and eventually empty Return sections
that the current script produces). Getting blank lines and whitespaces identical
have been hard.

So, yeah, if something is not handled well by the Perl version, the
Python version shall produce an identical result. I'm refraining to
try fixing any already existing issues there.

> I will wait
> until later to test the current known bugs that I know about in (Perl) kernel-doc.
> 
> For a preview of most of them, you can read:
> https://lore.kernel.org/linux-doc/3a6a7dd0-72f1-44c6-b0bc-b1ce76fca76a@infradead.org/
> 
> and its follow-up email (today).
> 
> There are quite a few problems with parsing function parameters that use
> typedefs.

Thanks for that!

Let's address when we finish the transition.

Thanks,
Mauro


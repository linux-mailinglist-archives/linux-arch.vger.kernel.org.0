Return-Path: <linux-arch+bounces-11970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE3AB953E
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F323A20697
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 04:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA91FE469;
	Fri, 16 May 2025 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jy76Oxt7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCAE46BF;
	Fri, 16 May 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747369070; cv=none; b=TwVDHrgLWtkL1fuH1hJAndtD1bG1CWA/yCs2OSdJcwCvYIUDubpa4fviSdvDwTJwTZWQYobaunX0CfiSZYAKAS3/Zq4YbKkZI6a1+EZiJh8HI1Xf1Uq3AHdU9CoUdeDoHaS4e5mRXnxNlF0Gf+XkWrsg4bytAo0pgYJpvo0bazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747369070; c=relaxed/simple;
	bh=fo0kGEt3xsQGH4DXkiyqeaGPVcZ+CgzUwd9NtP1cDRY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GgLdOgQaMnrauqhOVJdKDjeHyLgfEkl9RuPEBnHbS8wIZ8w6ZUpuvMlZPYHP9WwbKTBatwFZ8P0Zb6i/Sf9RWiyq84HGDAjD3BNC8rfYDBAIRiVCtsTQ8dEw+QefhWsFqOro7Y60CvuqKZbHqYix7g2693oS9x5ou+9rrZJ8Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Jy76Oxt7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54G4HHvo3930946
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 21:17:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54G4HHvo3930946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747369037;
	bh=fo0kGEt3xsQGH4DXkiyqeaGPVcZ+CgzUwd9NtP1cDRY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Jy76Oxt7q9vcscnlFVCHV/dq/Em1YeRVQiW21eQlLrtHlIpON1mkefSz1bRmnYgj1
	 Lr/ZvZNsmmvF3Jel3o/s/QZ2P3Xh7DRMWClrr4PH69Nv4frZpUoOUip+9YDuhOtKpL
	 4q68kAWN1hbqr0+tLGVKtLE4alWZDrJSUz63JvNBAr+tc0SggAojL01q5A97sI/1/O
	 711OAK+71D3HjQR6UhjtmYFwRTNc42pC2txjrDUnaWjevGVhOO2qxHsxMPEuj2xmv0
	 FZXwxqA41YafBYL4jLQ/7JwXBSrs8SpM8EpBLn+jD2iDiSjhaq7+mDbNNszkV2x/jw
	 J7BLV7QL3NhCw==
Date: Thu, 15 May 2025 21:17:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Willy Tarreau <w@1wt.eu>
CC: enh <enh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Subject: Re: Metalanguage for the Linux UAPI
User-Agent: K-9 Mail for Android
In-Reply-To: <20250516034232.GA12472@1wt.eu>
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com> <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com> <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com> <20250516034232.GA12472@1wt.eu>
Message-ID: <A89533DF-E2F9-4536-A00D-4E3685565E67@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 15, 2025 8:42:32 PM PDT, Willy Tarreau <w@1wt=2Eeu> wrote:
>On Thu, May 15, 2025 at 02:24:29PM -0700, H=2E Peter Anvin wrote:
>> On 5/15/25 13:26, enh wrote:
>> > On Thu, May 15, 2025 at 4:05=C2=A0PM H=2E Peter Anvin <hpa@zytor=2Eco=
m> wrote:
>> > >=20
>> > > OK, so this is something I have been thinking about for quite a whi=
le=2E
>> > > It would be a quite large project, so I would like to hear people's
>> > > opinions on it before even starting=2E
>> > >=20
>> > > We have finally succeeded in divorcing the Linux UAPI from the gene=
ral
>> > > kernel headers, but even so, there are a lot of things in the UAPI =
that
>> > > means it is not possible for an arbitrary libc to use it directly; =
for
>> > > example "struct termios" is not the glibc "struct termios", but
>> > > redefining it breaks the ioctl numbering unless the ioctl headers a=
re
>> > > changed as well, and so on=2E However, other libcs want to use the =
struct
>> > > termios as defined in the kernel, or, more likely, struct termios2=
=2E
>> >=20
>> > bionic is a ("the only"?) libc that tries to not duplicate _anything_
>> > and always defer to the uapi headers=2E we have quite an extensive li=
st
>> > of hacks we need to apply to rewrite the uapi headers into something
>> > directly usable (and a lot of awful python to apply those hacks):
>> >=20
>> > https://cs=2Eandroid=2Ecom/android/platform/superproject/main/+/main:=
bionic/libc/kernel/tools/defaults=2Epy
>> >=20
>>=20
>> Not "the only"=2E
>
>Indeed, nolibc (/tools/include/nolibc) directly includes uapi as well, an=
d
>since nolibc doesn't compile anything but only exposes include files, the=
se
>appear as-is in the application=2E So far the headers look clean enough f=
or
>our use cases and have not caused problems=2E But admittedly, application=
s
>are small and limited (selftests and init code)=2E
>
>One thing we've been considering which we would find convenient there
>would be to generate an indirection layer for all files that would includ=
e
>the right one depending on the detected arch so as to ease compilation fo=
r
>any arch with all the uapi files available, as it seems totally feasible
>right now (i=2Ee=2E each =2Eh file would just have "#if defined(__arch_xx=
x__)
>#include <arch_xxx/foo=2Eh>" etc)=2E We could imagine having a
>"make install-all-headers" target to produce that thing for example=2E I'=
m
>sharing this so that you can also have this in mind to consider whether o=
r
>not your chosen approach would break that possibility=2E
>
>Just my two cents,
>Willy

Ah yes, nolibc; basically klibc reinvented=2E=2E=2E

<ducks and runs>


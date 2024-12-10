Return-Path: <linux-arch+bounces-9354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BE9EB919
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1366518893EE
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5784E2046A2;
	Tue, 10 Dec 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBgGZczc"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863E86320
	for <linux-arch@vger.kernel.org>; Tue, 10 Dec 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854465; cv=none; b=bAePwZ9nvxZ5rJp1gxeBR+WkIQAzzV2WI0H5XiTuDzQ8fx6oS3rbXc7i6/c6Js2ybEg+rXbVER+f38UZMquFMFm05ALmpJH3+U6EEKaLQ0E95gmKUSaZT1PCsqm2e/YzqcOU1oVybCOY+oAm0qBW4UdL4YkLOSopM+eulJtJkiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854465; c=relaxed/simple;
	bh=58kxISxrk23kE8TYDeRPpcHawB18ecVmjqHz2YA7IpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nlSWzuGlOmrXRvpBjbNSvM0rvkHCuzUkoiQwzYPsa/A0fknf7UjAllcWgfVW2dScVjfcrb9W1ozh89DLocQZGjq/y2nC9EH8MiB1mQEUNNZ4CzOgNuiuo8cR413KsAttpaZQ3+eHs8uvXRM9aa7lkBHFvHZnt7OT11DtuvCvG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBgGZczc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733854462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92N47u4FApm/UnRcaQzi7CS8Y7ujQ0vFLMHe5hOUSYI=;
	b=XBgGZczc9ozUqwQx2Baoatlf579ZXFX68GavT51i+VO1NGmh5i4aHCXa177ibZLq+SHziM
	XJV5PqyEBPwwFxprKbSSznn6p9Nw/1xTgUVLsaiobLs8XV6xa/nYz52wrJ53/S0M6J2m9N
	5cKM6++QhOzuOwnwFRgKQAnObC587p0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-EVRDHubrMeKT-pbkwqreKw-1; Tue,
 10 Dec 2024 13:14:21 -0500
X-MC-Unique: EVRDHubrMeKT-pbkwqreKw-1
X-Mimecast-MFC-AGG-ID: EVRDHubrMeKT-pbkwqreKw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10AB01955DA8;
	Tue, 10 Dec 2024 18:14:18 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0926A300018D;
	Tue, 10 Dec 2024 18:14:09 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>,  Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
In-Reply-To: <20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
	(Aleksa Sarai's message of "Thu, 10 Oct 2024 07:40:35 +1100")
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
	<20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
Date: Tue, 10 Dec 2024 19:14:07 +0100
Message-ID: <87y10nz9qo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Aleksa Sarai:

> sched_getattr(2) doesn't care about trailing non-zero bytes in the
> (ksize > usize) case, so just use copy_struct_to_user() without checking
> ignored_trailing.

I think this is what causes glibc's misc/tst-sched_setattr test to fail
on recent kernels.  The previous non-modifying behavior was documented
in the manual page:

       If the caller-provided attr buffer is larger than the kernel's
       sched_attr structure, the additional bytes in the user-space
       structure are not touched.

I can just drop this part of the test if the kernel deems both behaviors
valid.

Thanks,
Florian



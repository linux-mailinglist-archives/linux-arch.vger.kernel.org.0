Return-Path: <linux-arch+bounces-749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF73808BE6
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E9E1F2109A
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52944C85;
	Thu,  7 Dec 2023 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnwxy4oH"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D614510C2
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701963176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rO0LOvSsYUy+BXiNU5frBHIkiTV2KkiJuS/MBqYnFgM=;
	b=Gnwxy4oHZxeEnD37rgRURXbqtpwYUcq1EaK3T6+JHrAnyQEZ+ySMCOBqabHFNCUzqbEkIo
	SVBDpDxcUS5x436UK0YCP6+yz08+e1U8FyebS/QHLHjh8N7PSJsaSQ4WeVlkBJOCLbsC0o
	FXnHOoUvPm7zBXjEB6mMkAUbpSkPOkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-haFiz_prNXKDzFwaWDEU7g-1; Thu, 07 Dec 2023 10:32:54 -0500
X-MC-Unique: haFiz_prNXKDzFwaWDEU7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1694910334AA;
	Thu,  7 Dec 2023 15:32:54 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA77111E400;
	Thu,  7 Dec 2023 15:32:52 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-api@vger.kernel.org,  x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
	<87v89dvuxg.fsf@oldenburg.str.redhat.com>
	<1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
	<202312061236.DE847C52AA@keescook>
	<4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
Date: Thu, 07 Dec 2023 16:32:51 +0100
In-Reply-To: <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183> (Alexey Dobriyan's
	message of "Thu, 7 Dec 2023 17:57:05 +0300")
Message-ID: <8734wehvto.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

* Alexey Dobriyan:

> On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
>> On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
>> > Report available page shifts in arch independent manner, so that
>> > userspace developers won't have to parse /proc/cpuinfo hunting
>> > for arch specific strings:
>> > 
>> > Note!
>> > 
>> > This is strictly for userspace, if some page size is shutdown due
>> > to kernel command line option or CPU bug workaround, than is must not
>> > be reported in aux vector!
>> 
>> Given Florian in CC, I assume this is something glibc would like to be
>> using? Please mention this in the commit log.
>
> glibc can use it. Main user is libhugetlbfs, I guess:
>
> 	https://github.com/libhugetlbfs/libhugetlbfs/blob/master/hugeutils.c#L915
>
> Loop inside getauxval() can run faster than opendir().

Is libhugetlbfs still maintained?  Last commit was three years ago?

Thanks,
Florian



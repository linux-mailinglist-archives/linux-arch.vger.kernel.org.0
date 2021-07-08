Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49A3C1535
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGHOe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 10:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231905AbhGHOeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 10:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625754703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mReZdr+kDhUGUhWJ8r6VOESdc8Yx9vE3TvsNv2E5jwY=;
        b=h3iVUSfBjp4gsHQpYdd3ITootApBJFVhqUq6vV0nYTdVaa12V20xsNPO0AYEIX8ba5WPhw
        i/vz1CHeuktC9Vn4ov/EpYb5Sl/H/PhGvcWVcp7FWg+L02MkINJeDtCTCtcHW81DAevUoc
        NhOjYlMg41v3wulI0L2fIBkTlAAuP5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-A5jZ9OlJN0WgollNuj_Mgg-1; Thu, 08 Jul 2021 10:31:40 -0400
X-MC-Unique: A5jZ9OlJN0WgollNuj_Mgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2019D1023F6B;
        Thu,  8 Jul 2021 14:31:32 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F3B5421F;
        Thu,  8 Jul 2021 14:31:29 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
References: <87tulo39ms.fsf@oldenburg.str.redhat.com>
        <e376bcb9-cd79-7665-5859-ae808dd286f1@intel.com>
        <878s2hz6g3.fsf@oldenburg.str.redhat.com>
        <b3b104cd-72d9-7f5c-116b-414c6ebf448d@intel.com>
Date:   Thu, 08 Jul 2021 16:31:28 +0200
In-Reply-To: <b3b104cd-72d9-7f5c-116b-414c6ebf448d@intel.com> (Dave Hansen's
        message of "Thu, 8 Jul 2021 07:19:21 -0700")
Message-ID: <87sg0oswqn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Hansen:

> On 7/7/21 11:05 PM, Florian Weimer wrote:
>>> This looks basically like someone dumped a bunch of CPUID bit values and
>>> exposed them to applications without considering whether applications
>>> would ever need them.  For instance, why would an app ever care about:
>>>
>>> 	PKS =E2=80=93 Protection keys for supervisor-mode pages.
>>>
>>> And how could glibc ever give applications accurate information about
>>> whether PKS "is supported by the operating system"?  It just plain
>>> doesn't know, or at least only knows from a really weak ABI like
>>> /proc/cpuinfo.
>> glibc is expected to mask these bits for CPU_FEATURE_USABLE because they
>> have unknown semantics (to glibc).
>
> OK, so if I call CPU_FEATURE_USABLE(PKS) on a system *WITH* PKS
> supported in the operating system, I'll get false from an interface that
> claims to be:
>
>> This macro returns a nonzero value (true) if the processor has the
>> feature name and the feature is supported by the operating system.
>
> The interface just seems buggy by *design*.

Yes, but that is largely a documentation matter.  We should have said
something about =E2=80=9Cuserspace=E2=80=9D there, and that the bit needs t=
o be known to
glibc.  There is another exception: FSGSBASE, and that's a real bug we
need to fix (it has to go through AT_HWCAP2).

If we want to avoid that, we need to go down the road of a curated set
of CPUID bits, where a bit only exists if we have taught glibc its
semantics.  You still might get a false negative by running against an
older glibc than the application was built for.  (We are not going to
force applications that e.g. look for FSGSBASE only run with a glibc
that is at least of that version which implemented semantics for the
FSGSBASE bit.)

Thanks,
Florian


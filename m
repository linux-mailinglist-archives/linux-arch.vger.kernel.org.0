Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2243C155B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGHOoA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 10:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231917AbhGHOn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 10:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625755277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVHdtokfwVvo9NLtbFn0ekZdo09a+Ervl/zkT6BQW3c=;
        b=SJdamD9QGYh4hg2HHRTZFfTp54YMKRYVi0PVnV+cl6oYxFnbDJcfUbsB28rOcD3VH/pxrt
        nqhoa8CwqQdWuyikhgdBsLZHAbgvEX+ETBtmg934QgnCJee7GQ9rkJSFxqYN89ox59AIx4
        5dVTbUdccOvkP9eWTS/jf0EwMG162lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-f2NipTGrOE2JkhbqiqCatA-1; Thu, 08 Jul 2021 10:41:16 -0400
X-MC-Unique: f2NipTGrOE2JkhbqiqCatA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76EBC18414A0;
        Thu,  8 Jul 2021 14:41:14 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B3510023AB;
        Thu,  8 Jul 2021 14:41:11 +0000 (UTC)
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
        <87sg0oswqn.fsf@oldenburg.str.redhat.com>
        <ba004c50-a630-27f4-5fb0-c6ad2b1f1e06@intel.com>
Date:   Thu, 08 Jul 2021 16:41:09 +0200
In-Reply-To: <ba004c50-a630-27f4-5fb0-c6ad2b1f1e06@intel.com> (Dave Hansen's
        message of "Thu, 8 Jul 2021 07:36:44 -0700")
Message-ID: <87lf6gswai.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Hansen:

> That's kinda my whole point.
>
> These *MUST* be curated to be meaningful.  Right now, someone just
> dumped a set of CPUID bits into the documentation.
>
> The interface really needs *three* modes:
>
> 1. Yes, the CPU/OS supports this feature
> 2. No, the CPU/OS doesn't support this feature
> 3. Hell if I know, never heard of this feature
> 	
> The interface really conflates 2 and 3.  To me, that makes it
> fundamentally flawed.

That's an interesing point.

3 looks potentially more useful than the feature/usable distinction to
me.

The recent RTM change suggests that there are more states, but we
probably can't do much about such soft-disable changes.

Thanks,
Florian


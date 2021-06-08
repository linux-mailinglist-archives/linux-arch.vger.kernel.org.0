Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623D239EB94
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFHBnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 21:43:09 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:38592 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFHBnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 21:43:09 -0400
Received: by mail-pg1-f179.google.com with SMTP id 6so15251659pgk.5;
        Mon, 07 Jun 2021 18:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=LmbJ2cp9d+faibVwJt5sXOKKJnAg7e+IPDELoo8ZgrE=;
        b=e7ddUgQHWp77SiSJqo65Mn37u7qIgCnEabvtOd3R9qWfDVGI61SBgkXCjB2Ov6LMz8
         ddQsE4VpbqP/wwrnUFb4cBfGE0TeCFOHqA7eeXrupmE33NXDtezdF4f+KL8fUPXvAuUZ
         SWjqXeFIC27Iwu4vJDWdL51ccU8z3UefeSc9H3q78+dYrGc0WAvulbioViTVOFP/w43t
         JCOVqKKQSD086R+DVdXo4G/wlMAPqXXUNVSBdfdhCTE5z3F+gHXef0rCm4/dJPlfzhiW
         BSSIzbjkvr06zDHkSDjCKEUKW/+VTIerWbVfbBwRH4o5KfV2y8wRn4GACnH6bPZsrMPJ
         fXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=LmbJ2cp9d+faibVwJt5sXOKKJnAg7e+IPDELoo8ZgrE=;
        b=rwh1y2QDkNjPMFdwGU0Uv0ROcqPtlXvZP371BqVxiaoyvWwrIf6sHGmWXEAfanIP4i
         e3+YcvwpdKVvDfwgdEiafEjSxXMGigRA2FGLr6C6ci+GRUjATrRQko+FoT0WAcVVsOmJ
         nfYavvxLLEu0pUG9Rk9cV546CiNuoTafbA7xylfvv7segx5DyuyEZIo0KR6jSIKJtB4x
         mroxCux4jdc87t3kolo+ypZmG+NO2hGwPbRvMldBPCIvgGPiDPGjI0HqL1jAhQBKw3hy
         71ztsq68cy+CtcJc6kFOqSPw9dRt4rHD3GKJIZXn9k1IQnozeOq3zpX5sHUoOfnC6C5U
         2ZhQ==
X-Gm-Message-State: AOAM533sxrMvCd5CYFETd0uo97v+SG1ik4GlWP7IlZiVJsbQ/HcnW685
        B0EQIfJ24ZfEG2CAOYlEmjs=
X-Google-Smtp-Source: ABdhPJzOfkIzeToLfJJOUxLbidAvCn+caiAWIe+szT2HeJWl8ScK6XZBhdd+ERrJwrp2bhftZQZfEw==
X-Received: by 2002:a63:d08:: with SMTP id c8mr2962362pgl.248.1623116402237;
        Mon, 07 Jun 2021 18:40:02 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id p11sm13524395pjo.19.2021.06.07.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:40:01 -0700 (PDT)
Date:   Tue, 08 Jun 2021 11:39:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/4] lazy tlb: introduce lazy mm refcount helper
 functions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-2-npiggin@gmail.com>
        <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
In-Reply-To: <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1623116020.vyls9ehp49.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of June 8, 2021 9:49 am:
> On Sat,  5 Jun 2021 11:42:13 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
>> This makes lazy mm references more obvious, and allows explicit
>> refcounting to be removed if it is not used.
>>=20
>> ...
>>
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -1314,14 +1314,14 @@ void kthread_use_mm(struct mm_struct *mm)
>>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>>  	WARN_ON_ONCE(tsk->mm);
>> =20
>> +	mmgrab(mm);
>> +
>>  	task_lock(tsk);
>>  	/* Hold off tlb flush IPIs while switching mm's */
>>  	local_irq_disable();
>>  	active_mm =3D tsk->active_mm;
>> -	if (active_mm !=3D mm) {
>> -		mmgrab(mm);
>> +	if (active_mm !=3D mm)
>>  		tsk->active_mm =3D mm;
>> -	}
>=20
> Looks like a functional change.  What's happening here?

That's kthread_use_mm being clever about the lazy tlb mm. If it happened=20
that the kthread had inherited a the lazy tlb mm that happens to be the=20
one we want to use here, then we already have a refcount to it via the=20
lazy tlb ref.

So then it doesn't have to touch the refcount, but rather just converts
it from the lazy tlb ref to the returned reference. If the lazy tlb mm
doesn't get a reference, we can't do that.

Thanks,
Nick

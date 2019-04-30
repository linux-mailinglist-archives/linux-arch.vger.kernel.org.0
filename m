Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73839EED3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2019 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfD3Cqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 22:46:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3Cqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 22:46:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w20so5405127plq.3;
        Mon, 29 Apr 2019 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=ZpJQsgca0/LVXSQJRGMNekhujVFwpXEhIaVfT5sfHAQ=;
        b=kpvZIF17L9G03YJq6KG5vubutPEqXMbRlH2u3ftH+O+AKf2OGcWUdaTlOlazuQl36C
         T3YXt2hVzvcuh99ojGDB+1JXLF5u3RMsWoFk8UK3vWKWLRxhP85QZ7kQvaxE4q94m60X
         44wOHbQ63X6mjvJxlsky7M9GOFR4Tig1feUjYeiVoPj9F7gOx8xSGLksb14lXxnn7HsF
         qk6HxsKulWIihT8kN9ZUDmrDJRGFsrutS08zYZkGoTRuNDGSvzb1jhQCsuLv21wgUENE
         i1LLb6rNnKp3tPGoQ9XSv5thHAWIJe290G7aDuUqHbmu7BQTTrkG0YQwSxZlYAZ22wXj
         JksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=ZpJQsgca0/LVXSQJRGMNekhujVFwpXEhIaVfT5sfHAQ=;
        b=uB5tYcw4T6OLTRMNIEcm7J52yZLlsCIYFUGELLgsPl+rKrW4AYJnjCD8z22dO/eHQx
         sNZZ3+IwtZFVZfvLN0as4aAbtI2WHfZ/SpNW//44d1RefLrryqY83e4XZFmPnyPsfuF6
         UxrIPN8bkbasB0Bnps03L5f6EFlG68TC6KRPNQWuy2YbHq0y7jbU0X5M0KuG/FEoc6gB
         J5WYsW5MlrqF0YRfNDP4rMNcJlKcvAlLyIrMqUHg8p10MVBigAVAdKcYrEiNBGh7lM3j
         JGMCnQtgk5FsysL+9hS+XrKMpmLbQVek6GsurrQBZl64xHJ2gfda/sDx2K9RsdJ7s28V
         ZKmg==
X-Gm-Message-State: APjAAAVA2yFywBkBY+OV1PfCx5dHIZawZPPmhWZhE2fuKcDWtCr+tdM7
        /V+1sHr7/xzc35B5fqX6mME=
X-Google-Smtp-Source: APXvYqxJ3bN9p+xxhe52PIxCipNM8t93ISXM/JyGKmdLl5vcETLdScqbbeuA8ScDP+AwIhXCzD2n9w==
X-Received: by 2002:a17:902:8c85:: with SMTP id t5mr7315616plo.23.1556592408950;
        Mon, 29 Apr 2019 19:46:48 -0700 (PDT)
Received: from localhost (60-240-193-213.tpgi.com.au. [60.240.193.213])
        by smtp.gmail.com with ESMTPSA id 17sm66294013pfw.65.2019.04.29.19.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 19:46:46 -0700 (PDT)
Date:   Tue, 30 Apr 2019 12:46:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/5] Allow CPU0 to be nohz full
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190411033448.20842-1-npiggin@gmail.com>
        <20190425120427.GS4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425120427.GS4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556592099.38esq4uhhz.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter Zijlstra's on April 25, 2019 10:04 pm:
> On Thu, Apr 11, 2019 at 01:34:43PM +1000, Nicholas Piggin wrote:
>> Since last time, I added a compile time option to opt-out of this
>> if the platform does not support suspend on non-zero, and tried to
>> improve legibility of changelogs and explain the justification
>> better.
>>=20
>> I have been testing this on powerpc/pseries and it seems to work
>> fine (the firmware call to suspend can be called on any CPU and
>> resumes where it left off), but not included here because the
>> code has some bitrot unrelated to this series which I hacked to
>> fix. I will discuss it and either send an acked patch to go with
>> this series if it is small, or fix it in powerpc tree.
>>=20
>=20
> Rafael, Frederic, any comments?
>=20

Sorry to ping again, I guess people are probably busy after vacation.
Any chance we could get this in next merge window? Peter are you okay
with the config option as it is, then we can look at adapting it to
what x86 needs as a follow up (e.g., allow nohz CPU0 for
cpu0_hotpluggable case)?

Thanks,
Nick

=

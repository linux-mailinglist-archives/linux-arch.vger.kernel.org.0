Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018A33A5BEF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 06:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhFNEQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 00:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 00:16:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE5C061574;
        Sun, 13 Jun 2021 21:14:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c12so9598931pfl.3;
        Sun, 13 Jun 2021 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=v/XuIpHevb/aG8jpf/7Tm8j/ZOeYAcDGTVZ1vzayZjU=;
        b=NojfaKJjF7I+vmtv4AudrQr4fZ31clBSdSoSrNhvRiaaoRjP0hcOq5zjoUqwZfbem6
         kiqEbm/fR8rhUyje5JHyzQowYnBent1WxnPR87dcUzIvCwZiD5vPzkd8Y1HFHXFjQw+S
         PDIObhwXt0GSqqdRKsNV0ystEt1Xgewa502VdNSoGsz+8RvP4NNke5pqdEPKG61sIjR9
         zrIprtfx8A/XGEVyRokS+9xX13juCsdGYHKt1AYCpjqn3m/4XDWT8RsXoQc9O8NDy0aO
         cNW0omXvFEDHnNBcHnspbapQhp1VZDoduxDuIp9R0Z/xkjjWDccti8eSd/3aTu6yL0ET
         +9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=v/XuIpHevb/aG8jpf/7Tm8j/ZOeYAcDGTVZ1vzayZjU=;
        b=rUTJM87ixKOhUHqCvOCv4qH7j+5JxMT+SvWuwC1wl+ZBpRLNCyJnjGH7fznOMXaTHA
         tYxEYGlt68LghvOA50RRrsWAE23M181O1r/+VADPx21BfaQh11h/3bsrOn7SYR3RhCgA
         cGzjrJXVDw0rMk/OhHyIuTSZtcMQ0qICU3ZKfDDdoqmLqP1mlF+e3WiL6b/vIkJpwLDL
         UInvGmkXJ/o5Bp4ORDw8JGsteB+aIkUUVY48ZYcIqPKEeHZu971WerKSoJKxt9TWqvtb
         lsQgpGssiavcLZaMid6UChPhx2FjFAx3c0qqhBL4KnBfF7QDuhECKi/EDcHRf18aTH/S
         EAEw==
X-Gm-Message-State: AOAM530TnE09m7ZnXeOF9dW4txxe2+TVjuhEELcDILiGjhX0CcnhAlXs
        HZlnafSgQFwQ5/MMrzUJgSo=
X-Google-Smtp-Source: ABdhPJzZ9wnEZy27inqEptZjfCkLwrs5I5k1jE6HA2lgrlXlaM2wxjhHPW1eMgPD2Ba7RIpvdKtaWA==
X-Received: by 2002:a65:584c:: with SMTP id s12mr2898768pgr.309.1623644072944;
        Sun, 13 Jun 2021 21:14:32 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id fw16sm15749448pjb.30.2021.06.13.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 21:14:32 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:14:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
        <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
        <1623629185.fxzl5xdab6.astroid@bobo.none>
        <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
In-Reply-To: <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
MIME-Version: 1.0
Message-Id: <1623643443.b9twp3txmw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 14, 2021 1:52 pm:
> On 6/13/21 5:45 PM, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
>>> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>>>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb =
mm
>>>> when it is context switched. This can be disabled by architectures tha=
t
>>>> don't require this refcounting if they clean up lazy tlb mms when the
>>>> last refcount is dropped. Currently this is always enabled, which is
>>>> what existing code does, so the patch is effectively a no-op.
>>>>
>>>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>>>
>>> I am in favor of this approach, but I would be a lot more comfortable
>>> with the resulting code if task->active_mm were at least better
>>> documented and possibly even guarded by ifdefs.
>>=20
>> active_mm is fairly well documented in Documentation/active_mm.rst IMO.
>> I don't think anything has changed in 20 years, I don't know what more
>> is needed, but if you can add to documentation that would be nice. Maybe
>> moving a bit of that into .c and .h files?
>>=20
>=20
> Quoting from that file:
>=20
>   - however, we obviously need to keep track of which address space we
>     "stole" for such an anonymous user. For that, we have "tsk->active_mm=
",
>     which shows what the currently active address space is.
>=20
> This isn't even true right now on x86.

From the perspective of core code, it is. x86 might do something crazy=20
with it, but it has to make it appear this way to non-arch code that
uses active_mm.

Is x86's scheme documented?

> With your patch applied:
>=20
>  To support all that, the "struct mm_struct" now has two counters: a
>  "mm_users" counter that is how many "real address space users" there are=
,
>  and a "mm_count" counter that is the number of "lazy" users (ie anonymou=
s
>  users) plus one if there are any real users.
>=20
> isn't even true any more.

Well yeah but the active_mm concept hasn't changed. The refcounting=20
change is hopefully reasonably documented?

>=20
>=20
>>> x86 bare metal currently does not need the core lazy mm refcounting, an=
d
>>> x86 bare metal *also* does not need ->active_mm.  Under the x86 scheme,
>>> if lazy mm refcounting were configured out, ->active_mm could become a
>>> dangling pointer, and this makes me extremely uncomfortable.
>>>
>>> So I tend to think that, depending on config, the core code should
>>> either keep ->active_mm [1] alive or get rid of it entirely.
>>=20
>> I don't actually know what you mean.
>>=20
>> core code needs the concept of an "active_mm". This is the mm that your=20
>> kernel threads are using, even in the unmerged CONFIG_LAZY_TLB=3Dn patch=
,
>> active_mm still points to init_mm for kernel threads.
>=20
> Core code does *not* need this concept.  First, it's wrong on x86 since
> at least 4.15.  Any core code that actually assumes that ->active_mm is
> "active" for any sensible definition of the word active is wrong.
> Fortunately there is no such code.
>=20
> I looked through all active_mm references in core code.  We have:
>=20
> kernel/sched/core.c: it's all refcounting, although it's a bit tangled
> with membarrier.
>=20
> kernel/kthread.c: same.  refcounting and membarrier stuff.
>=20
> kernel/exit.c: exit_mm() a BUG_ON().
>=20
> kernel/fork.c: initialization code and a warning.
>=20
> kernel/cpu.c: cpu offline stuff.  wouldn't be needed if active_mm went aw=
ay.
>=20
> fs/exec.c: nothing of interest

I might not have been clear. Core code doesn't need active_mm if=20
active_mm somehow goes away. I'm saying active_mm can't go away because
it's needed to support (most) archs that do lazy tlb mm switching.

The part I don't understand is when you say it can just go away. How?=20

> I didn't go through drivers, but I maintain my point.  active_mm is
> there for refcounting.  So please don't just make it even more confusing
> -- do your performance improvement, but improve the code at the same
> time: get rid of active_mm, at least on architectures that opt out of
> the refcounting.

powerpc opts out of the refcounting and can not "get rid of active_mm".
Not even in theory.

Thanks,
Nick

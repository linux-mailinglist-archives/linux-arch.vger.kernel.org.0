Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA83A5B33
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 02:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFNAsl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 20:48:41 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43920 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhFNAsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 20:48:41 -0400
Received: by mail-pg1-f173.google.com with SMTP id e22so7286524pgv.10;
        Sun, 13 Jun 2021 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XxuG7Ca+3NTnEr0aQpNCozkotiEBll347Hs/ZeeBTEE=;
        b=mm2A1acBjDH7g2IowT4ikVA0PGuvvUKAqKzu0e1WiA7lFyUa/IlSllbZTfUlcwYGgI
         SwY2xIh2GjsYJSZkx8ezsCjaRxCJeKFP0aBwLHlECyiXyLU3CQsShC9mUFO88Jo2GW7j
         jHkGQsMV153/u1T9xp86sMn5EyV+97RBdP+HkwVmjTTcpG7/AwiY6g0VhXL00nWz6Ikz
         E6UhlEfr1QOet/Kb36AM9BRuYqt4j0SORqJJ4Ja0XHE13zOobYtwVo2w1hZS7ifKGRQG
         jrIlNZOrfeETCuB9HlDjdKurGlFn369VV65lIgM1JiNWrQ3vmKG7pG6rg48DFQu3FPjt
         wAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XxuG7Ca+3NTnEr0aQpNCozkotiEBll347Hs/ZeeBTEE=;
        b=Xz6zxRs4hW7Jn5dRE0Jd1a02/HIvS75Mn3wJ+6n4n3+ngFCcgiwsSlqMIyGgUNC2Ln
         JGMG/OpAXOp1CRM/iytc6BQz+tFrnSSSmkgtmHSYRCwA1t0dSASvY0MyLo/HLg9Ci0l5
         VmjZBeOD2oukjHg76EvfPA61Tbpvt2J9ALipZkjarZBd/cxvbiirTzkxNYX+NW4hjqGB
         OqOFcZbqgcdb/LaFTGFxYJOHF+eshfZSLGrz4H0vPB9iRE+j2dqb93r730dTOWpzheXI
         3EVEQMobnc5JoKzQ80vc/4U5LvxIC5pAsTRYGcrKzy+5RqBPQJzE6c6fBNiSZtW5nAOz
         RY9Q==
X-Gm-Message-State: AOAM532tyIzgJy3I0UDzILLyCo/XWAOhGEAvxIHGShsTxxv3x3hJ+U+i
        TGlK3ctS6T83X9G606GEGTM=
X-Google-Smtp-Source: ABdhPJx0cMBzdEpBTdoXhdRfERuKep5LD+E6eqItgLbvkLf7+nCitT8/U5nRSCNsZiXV0o1/PEHbmw==
X-Received: by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with SMTP id a20-20020a62bd140000b02902de8bf72df8mr19268697pff.60.1623631527972;
        Sun, 13 Jun 2021 17:45:27 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id em22sm2575307pjb.27.2021.06.13.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 17:45:27 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:45:22 +1000
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
In-Reply-To: <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
MIME-Version: 1.0
Message-Id: <1623629185.fxzl5xdab6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
>> when it is context switched. This can be disabled by architectures that
>> don't require this refcounting if they clean up lazy tlb mms when the
>> last refcount is dropped. Currently this is always enabled, which is
>> what existing code does, so the patch is effectively a no-op.
>>=20
>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>=20
> I am in favor of this approach, but I would be a lot more comfortable
> with the resulting code if task->active_mm were at least better
> documented and possibly even guarded by ifdefs.

active_mm is fairly well documented in Documentation/active_mm.rst IMO.
I don't think anything has changed in 20 years, I don't know what more
is needed, but if you can add to documentation that would be nice. Maybe
moving a bit of that into .c and .h files?

> x86 bare metal currently does not need the core lazy mm refcounting, and
> x86 bare metal *also* does not need ->active_mm.  Under the x86 scheme,
> if lazy mm refcounting were configured out, ->active_mm could become a
> dangling pointer, and this makes me extremely uncomfortable.
>=20
> So I tend to think that, depending on config, the core code should
> either keep ->active_mm [1] alive or get rid of it entirely.

I don't actually know what you mean.

core code needs the concept of an "active_mm". This is the mm that your=20
kernel threads are using, even in the unmerged CONFIG_LAZY_TLB=3Dn patch,
active_mm still points to init_mm for kernel threads.

We could hide that idea behind an active_mm() function that would always=20
return &init_mm if mm=3D=3DNULL, but you still have the concept of an activ=
e
mm and a pointer that callers must not access after free (because some
cases will be CONFIG_LAZY_TLB=3Dy).

> [1] I don't really think it belongs in task_struct at all.  It's not a
> property of the task.  It's the *per-cpu* mm that the core code is
> keeping alive for lazy purposes.  How about consolidating it with the
> copy in rq?

I agree it's conceptually a per-cpu property. I don't know why it was=20
done this way, maybe it was just convenient and works well for mm and=20
active_mm to be adjacent. Linus might have a better insight.

> I guess the short summary of my opinion is that I like making this
> configurable, but I do not like the state of the code.

I don't think I'd object to moving active_mm to rq and converting all
usages to active_mm() while we're there, it would make things a bit
more configurable. But I don't see it making core code fundamentally
less complex... if you're referring to the x86 mm switching monstrosity,
then that's understandable, but I admit I haven't spent enough time
looking at it to make a useful comment. A patch would be enlightening,
I have the leftover CONFIG_LAZY_TLB=3Dn patch if you were thinking of=20
building on that I can send it to you.

Thanks,
Nick

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E492227EA4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGULUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgGULUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:20:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977AEC061794;
        Tue, 21 Jul 2020 04:20:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so20722571wrj.13;
        Tue, 21 Jul 2020 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=cgE7yCvC2TsM3N9RxN0ivNvrTATSLMzpTj/dTB9AGDk=;
        b=mu8Irwtky5HM+EiEeEeJR5ujsfvK+4dRAQRaaVcc7HsqkvVK5OdZ66y3jHwGTwX8Cu
         zczEMY4FPKkfMJPyqoq/zEQTDqVrWHiKq35CWL+NseYxjRUXqM17lsfcA3S2fUbacz4F
         paoMeJ2RbHu5MMFCr9bSA1dbKVqhP5CQFlBIRXxKK2DBfodI5dmWrdix02VwYwBLvq7Y
         TftEIFzy6Oqpsf3KxqPjswQGUu4zx2fkccY9iW9azevcnJDENK3yYmxXnT8KmtHnkU+O
         QAlb9uxvjbo6Lx3o/O/kQVN+N4n65xMKivLjHruWEFxL5BOP2ogapw3UZF/MG5dgU8Tv
         2Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=cgE7yCvC2TsM3N9RxN0ivNvrTATSLMzpTj/dTB9AGDk=;
        b=qL82uYsPowA7MbjQOkjHd/3xRt/ye2bs5oF/qyJR1VGSv+NZrp0GsFynCGZCTmEfYV
         tBkR/Z66Ju6yDnmt7m5vGhVJMTey/jxOvUrL9fujW5KHDfdTAJL9siniwcedgkqW2LUO
         VcjJpG49NPPhNgqUwNA1lTCeV/J9Cts0Eftbd0p3WgIBD/WGSfpmNV2vKGQqr/Evd3Cd
         ehtgrtNsKOYTcYKKvb0fhzJ8P0lvhbp6f9l8aNSlTqUQW74KzrRTfAm9A/VIpVnhF2b6
         iZXA8W1QcGZNwrhnDBe+5itNG1OfSX+WSdnVcmcb/cZNHtm80YFfWw58m4cijYCD5VHj
         En4g==
X-Gm-Message-State: AOAM530aL0Xqk/xXVDL0Go1fUOljWH9Yz54I+oQMMWMW9u8rj46/lMJL
        Fs95b8hF/Foph1VO01Vx6cY=
X-Google-Smtp-Source: ABdhPJwmCaJOo8AdzQqS2eChCE+7XLE3Au1lXisG7/a/kYL/4vC9x9VNW5OotawEVy00sIUB49kphA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr28232045wrm.390.1595330417294;
        Tue, 21 Jul 2020 04:20:17 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id c188sm3106579wma.22.2020.07.21.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:20:16 -0700 (PDT)
Date:   Tue, 21 Jul 2020 21:20:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
        <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
        <20200709083113.GI597537@hirez.programming.kicks-ass.net>
In-Reply-To: <20200709083113.GI597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595329799.y24rka8cv4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 9, 2020 6:31 pm:
> On Wed, Jul 08, 2020 at 07:54:34PM -0400, Waiman Long wrote:
>> On 7/8/20 4:41 AM, Peter Zijlstra wrote:
>> > On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> > > Yes, powerpc could certainly get more performance out of the slow
>> > > paths, and then there are a few parameters to tune.
>> > Can you clarify? The slow path is already in use on ARM64 which is wea=
k,
>> > so I doubt there's superfluous serialization present. And Will spend a
>> > fair amount of time on making that thing guarantee forward progressm, =
so
>> > there just isn't too much room to play.
>> >=20
>> > > We don't have a good alternate patching for function calls yet, but
>> > > that would be something to do for native vs pv.
>> > Going by your jump_label implementation, support for static_call shoul=
d
>> > be fairly straight forward too, no?
>> >=20
>> >    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
>> >=20
>> Speaking of static_call, I am also looking forward to it. Do you have an
>> idea when that will be merged?
>=20
> 0day had one crash on the last round, I think Steve send a fix for that
> last night and I'll go look at it.
>=20
> That said, the last posting got 0 feedback, so either everybody is
> really happy with it, or not interested. So let us know in the thread,
> with some review feedback.
>=20
> Once I get through enough of the inbox to actually find the fix and test
> it, I'll also update the thread, and maybe threaten to merge it if
> everybody stays silent :-)

I'd like to use it in powerpc. We have code now for example that patches=20
a branch immediately at the top of memcpy which branches to a different=20
version of the function. pv queued spinlock selection obviously, and
there's a bunch of platform ops struct things that get filled in at boot=20
time, etc.

So +1 here if you can get them through. I'm not 100% sure we can do
it with existing toolchain and no ugly hacks, but there's no way to
structure things that can get around that AFAIKS. We'd eventually
use it though, I'd say.

Thanks,
Nick

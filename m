Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF99375285
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhEFKoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbhEFKoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 06:44:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C6C061763
        for <linux-arch@vger.kernel.org>; Thu,  6 May 2021 03:43:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g65so3107585wmg.2
        for <linux-arch@vger.kernel.org>; Thu, 06 May 2021 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IPAb1iGejVFT6zs+1sVzWtohMm9y7vdT/ZlQY8nTMls=;
        b=CJmSrhq7QsEwcXPUklSribLNMHu+Ig61DIAKupe53jRXLAcL7635N7xCM+oNG0c4ZY
         8ev/ZWDdszW/u9QNVB6h4Y3J2VRIr9GCmQi3hsajdOhjcHn20zwMb/BJf+7COTjwuurh
         wHLw25CRUjaNL84s07vqWB/ZX75Jvh9KtcUOCC6NvcsmmXSsFwfz9BZfAi+sdNlsHjIO
         DcQJsIsRiEZ1ql1QOuUAUGU4vMhAKJghQS9lKxJ0RegAfwgAhDlIErJ+tVRq2PlCWnpH
         zL9OjYqAdu1QCiDlD06rEruffC6Kd2ThS4kSGTXZaX0t5GYXLiHqpRQvJpuNx+vckXH7
         FMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IPAb1iGejVFT6zs+1sVzWtohMm9y7vdT/ZlQY8nTMls=;
        b=k5oKHmXfszzw2hCrbPigPPnjCM8xeo0vgg2dBcxiXaehcqTlRDwZVzDREEdimygJxn
         zi+QEN6ABRivxJnBckFhaqLLfEQqrO7bfyXd2CWtYEjA6JtaSNPDLV/riaWYLoJClvVQ
         jl/LJDfXhL6SZB7PmbFj3ba4xz8TBc35DNahvEphO6cp/uRmhSuH1Yz9y9hXc3+bUNSt
         XyGhFm9S/eD2kco0RB1NZd8SZVViaGBPfIpPA0x8gfTKIfKDqd8EWNfAYwtUYP3QAsV8
         JxIssoG2EAXac4UJjKJZkgQjdySkjUnon/CzHMoBqYUPKZBMUOMdkLmxceQNgN7Ki0PO
         e6VQ==
X-Gm-Message-State: AOAM530MxCINtgb5DLA/RIponjaqCQCodkC3BuI/eU+OijSiU6riPnlI
        wiDdLkvTCUXDIGweefqBtcPpow==
X-Google-Smtp-Source: ABdhPJypynseg74IHehTSi3Pil8TC2hAEsYDo7eDm35h6uolqeNTJhPX9pVUGFAaXhaa9H54RBVnNg==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr14228873wmb.58.1620297793837;
        Thu, 06 May 2021 03:43:13 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:56c7:a45c:aa57:32c4])
        by smtp.gmail.com with ESMTPSA id 3sm2757392wms.30.2021.05.06.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:43:12 -0700 (PDT)
Date:   Thu, 6 May 2021 12:43:07 +0200
From:   Marco Elver <elver@google.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
Message-ID: <YJPIO7r2uLXsW9uK@elver.google.com>
References: <m15z031z0a.fsf@fess.ebiederm.org>
 <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
 <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org>
 <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <CAMuHMdUXh45iNmzrqqQc1kwD_OELHpujpst1BTMXDYTe7vKSCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXh45iNmzrqqQc1kwD_OELHpujpst1BTMXDYTe7vKSCg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 06, 2021 at 09:00AM +0200, Geert Uytterhoeven wrote:
[...]
> No changes needed for other architectures?
> All m68k configs are broken with
> 
> arch/m68k/kernel/signal.c:626:35: error: 'siginfo_t' {aka 'struct
> siginfo'} has no member named 'si_perf'; did you mean 'si_errno'?
> 
> See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14537820/
> 
> There are still a few more references left to si_perf:
> 
> $ git grep -n -w si_perf
> Next/merge.log:2902:Merging userns/for-next (4cf4e48fff05 signal: sort
> out si_trapno and si_perf)
> arch/m68k/kernel/signal.c:626:  BUILD_BUG_ON(offsetof(siginfo_t,
> si_perf) != 0x10);
> include/uapi/linux/perf_event.h:467:     * siginfo_t::si_perf, e.g. to
> permit user to identify the event.
> tools/testing/selftests/perf_events/sigtrap_threads.c:46:/* Unique
> value to check si_perf is correctly set from
> perf_event_attr::sig_data. */

I think we're missing the below in "signal: Deliver all of the siginfo
perf data in _perf".

Thanks,
-- Marco

------ >8 ------

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index a4b7ee1df211..8f215e79e70e 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -623,7 +623,8 @@ static inline void siginfo_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
 
 	/* _sigfault._perf */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x14);
 
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bf8143505c49..f92880a15645 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -464,7 +464,7 @@ struct perf_event_attr {
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
-	 * siginfo_t::si_perf, e.g. to permit user to identify the event.
+	 * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
 	 */
 	__u64	sig_data;
 };
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index fde123066a8c..8e83cf91513a 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -43,7 +43,7 @@ static struct {
 	siginfo_t first_siginfo;	/* First observed siginfo_t. */
 } ctx;
 
-/* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
+/* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
 #define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
 
 static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9999C256422
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH2Cbf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 22:31:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44775 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2Cbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 22:31:34 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so2272051ilc.11;
        Fri, 28 Aug 2020 19:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzn0G0FGdCJWuCIIWPA/ls8zYbx96IZfjwnp4qZytiM=;
        b=s5/Mdj9h0lo1rw/FQJPbu9ZMPP0mSin2r2Sd1CEi3wgYwrOPt7DN4Z0WzzkXR/OBYf
         Mv3nZiu+31QtkfqL312cqZvcVBWxaZAnhYWMWzTyHGE5WK8TVJFExcsG6/GidEDKs8oN
         HmVhNqxc8PlcT1++8QHT/g2++xdPhj/WUC3Sr6U4d/gEn+wBsdw42jK7gv94HqPWJpns
         VC0wLgFnclxnA5rYvD/0rVFKK3C8HdnVmfz3scb3Ma+Jy/b2RtKHpP163z7OEgiKM/MO
         O+J996aToE3cFGFANlLew64S7YA0L9OWUVkHIMA2Mfk4345lwtY5H1bRPmQEzIPoySlU
         selg==
X-Gm-Message-State: AOAM533DhrtOo7IdnPjhhaUHhmmxhGqzLPmB1SNP6lhfRNYs17v0nide
        1ybiw2aPbXX90+wGFgk6rhBMDWHmQLxJs16fOO4=
X-Google-Smtp-Source: ABdhPJz/VF9WXjkpJvJJU5x52nJawUOXGtjYny3gjvFyKd/Nf0m+fGjv+VL4pXvYyOEcojZyiPtt0b2YX1vSC2QuEPE=
X-Received: by 2002:a92:8954:: with SMTP id n81mr1451292ild.164.1598668293465;
 Fri, 28 Aug 2020 19:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.594247581@infradead.org>
 <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
 <20200828181341.c1da066360c6085d48850e22@kernel.org> <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
 <CAFCw3dqhd35mdFE_SjUYtLrxNUYwdO-iFAonZ1OXu9CGBsyGrw@mail.gmail.com>
In-Reply-To: <CAFCw3dqhd35mdFE_SjUYtLrxNUYwdO-iFAonZ1OXu9CGBsyGrw@mail.gmail.com>
From:   Cameron <cameron@moodycamel.com>
Date:   Fri, 28 Aug 2020 22:31:17 -0400
Message-ID: <CAFCw3dqDwP-RM20M7Uv=RS7aBHe=DLr3akhDY_XM8W0foiAEeQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with freelist
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 10:29 PM Cameron <cameron@moodycamel.com> wrote:
> I thought about this some more, and actually, it should be safe.

Although I should note that it's important that the flags/refcount are
not overwritten
even after the node is taken off the freelist.

Cameron

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977EF254B5D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH0RBH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 13:01:07 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41990 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0RBF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 13:01:05 -0400
Received: by mail-il1-f196.google.com with SMTP id t13so5462251ile.9;
        Thu, 27 Aug 2020 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUGmecZC05So9bfTB01ZD1qXr2emWnACEIUX2VAYiRk=;
        b=eT0D+EXRZsoDgMQ00nXXqx07QLPxOv80xq4+LJlI/adlrOPJtJqU2St86/1M3Hd+8L
         L2i5VoEMgY5EpGizoOGLA/zn8t6I/fNarsV5EVtND8WsbV8VCwteUJNVSGQHp3Io9lkW
         Z3EEKlhRu1S0wPrPCg8QYxrPal+YAmGd3tdd8Nw2+8wK12rr5sjRlljn9zHNvT3BeuoJ
         RfQ9DhE+zujdAjukdqDZhu7w9Q4X5O8uHf77adgucPRxJj4XLkc7Ywrz6645gjmiWXCr
         I+eO4NwocPJU41E/1tMTWETwpFipNVEvigEVm+o6d5nJdSHKJFHHC7pybffDSCJXHE2f
         eXhg==
X-Gm-Message-State: AOAM532htuTalZ4wLxMf7ZfJdPpNlkPy+gRaXgdx10ui8dSB03V3a0QT
        MytF1Ua40bOY7/oVMjBnWDft1kW2lSSMqoMw3/w=
X-Google-Smtp-Source: ABdhPJyicomFpfKaaKZTiGRcLEvVk0LKymlHgawv4FBLiRuqsdSgF/vj/VU/Dg1GCmEbKIfSfH3TojkA5KJQIipnZXk=
X-Received: by 2002:a92:90d:: with SMTP id y13mr16478107ilg.278.1598547664836;
 Thu, 27 Aug 2020 10:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.535381269@infradead.org>
 <20200827163755.GK1362448@hirez.programming.kicks-ass.net>
 <CAFCw3doX6KK5DwpG_OB331Mdw8uYeVqn8YPTjKh_a-m7ZB9+3A@mail.gmail.com> <20200827165605.GL1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200827165605.GL1362448@hirez.programming.kicks-ass.net>
From:   Cameron <cameron@moodycamel.com>
Date:   Thu, 27 Aug 2020 13:00:49 -0400
Message-ID: <CAFCw3dp4Zz6EL=qKUUq7pgRzQVDdKj=RC70u35FEV_Obq056Pg@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:56 PM <peterz@infradead.org> wrote:
> Are you Ok with the License I put on it, GPLv2 or BDS-2 ?
Yes, both GPLv2 and BSD-2 (my personal favourite) are fine.

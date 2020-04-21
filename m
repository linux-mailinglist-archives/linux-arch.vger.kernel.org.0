Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3461B2B0F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDUPVx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUPVx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 11:21:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910ADC061A10;
        Tue, 21 Apr 2020 08:21:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so11394555lfh.11;
        Tue, 21 Apr 2020 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=G5VKAhwHSCkO13lB215fVqAbEvC64vZ494rjxezJpPQ=;
        b=KQDOQIuYneRe17hjshDQMNMWIVYgSnxDl/MUcQO7/ctdXD/OwiKyztSJ9kBBozfphB
         wTBUackTJYCmsg3lv7OPDU2u/t4J+/uy/R9l1/uoJRcFGNjbvn4fF7yOY7notipPWj3P
         Sl/G0dSNp7if+lJ6JGoK7Ort4AgC5yjBc/qCMqPx664s1PT/cbKDDzK7C6jBoiLCKTLD
         PhejT2sgf5I4vmbzWJ/jMza/VtHlB52cU3zC2Qo83ZpgvWJ6d4Fuho8topf1atJPuVbJ
         A/s5HANrEO+C0eLN67wDFyqoySr0p+xAQW2PjQulfwQD+6fGXlcZNlYZnboECZeC1uIL
         e5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=G5VKAhwHSCkO13lB215fVqAbEvC64vZ494rjxezJpPQ=;
        b=eHfFSS/eQ5KLaVBQDr37yabMlwGl/a0ik3AxeCQurB+GQYvEy1KaXrum5K3I1kzofk
         m0oOthUqkvIvFRaxrzpTNeDQuvpueGEJAZ36Z5AYRMiiTSBPmQ8177/mIQPKxNXXVg8G
         t1srXNb9qOyveOxkF2H1MW1UrBgKDLd+uKjgidfbPDCSIs3C4I5W7GZa3Bn1pIqEkXn1
         AmIBVNhTekAPZm+U05rTZeb5Fri+gif6dou8r+Cotn//kMpy8SpSRNxuLyFzQC2Oddn0
         Xcv6G9Rl9543Tgy8xFDoi1DXgIwIcggNxRBD/WTweVDfRDN2TlwmwXdKzcMG/JUsdZQG
         0FOQ==
X-Gm-Message-State: AGi0Pua4+YMM31I/rVcBcu2Kkl0nJbtED7wPHAlP8Kb2FfDKoEXO+KY7
        QzjZyJtHr6GdnIMIxIA6HC8=
X-Google-Smtp-Source: APiQypLsR0OuLTnQmGywi2EGGHlC8QJupSgTFfb2fbNmeMRTUt8E9BhC0cHHQyCBDe+ZmPqM8p13kQ==
X-Received: by 2002:a05:6512:3081:: with SMTP id z1mr14129181lfd.102.1587482510651;
        Tue, 21 Apr 2020 08:21:50 -0700 (PDT)
Received: from localhost ([176.212.68.26])
        by smtp.gmail.com with ESMTPSA id 125sm2373382lfb.89.2020.04.21.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:21:49 -0700 (PDT)
Date:   Tue, 21 Apr 2020 08:21:48 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alex Belits <abelits@marvell.com>
Cc:     yury.norov@gmail.com, "frederic@kernel.org" <frederic@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 00/12] "Task_isolation" mode
Message-ID: <20200421152148.GA16576@yury-thinkpad>
Reply-To: 4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> This is an update of task isolation work that was originally done by
> Chris Metcalf <cmetcalf@mellanox.com> and maintained by him until
> November 2017. It is adapted to the current kernel and cleaned up to
> make this functionality both more complete (as in, prevent isolation
> breaking in situations that were not covered before) and cleaner (as
> in, avoid any dubious or fragile use of kernel interfaces, and provide
> clean and reliable isolation breaking procedure).
> 
> I guess, I have to explain why such a thing exists.
> 
> ...
> 
> My thanks to Chris Metcalf for design and maintenance of the original
> task isolation patch, Francis Giraldeau <francis.giraldeau@gmail.com>
> and Yuri Norov <ynorov@marvell.com> for various contributions to this
> work, and Frederic Weisbecker <frederic@kernel.org> for his work on
> CPU isolation and housekeeping that made possible to remove some less
> elegant solutions that I had to devise for earlier, <4.17 kernels.
> 
> The previous patch (v16 by Chris Metcalf) is at:
> 
> https://lore.kernel.org/lkml/1509728692-10460-1-git-send-email-cmetcalf@mellanox.com

Alex,

For patches that are not authored by you, you removed authors' SOB, like in
patch 8 of this series.

Please CC me for next revisions.

Thanks,
Yury

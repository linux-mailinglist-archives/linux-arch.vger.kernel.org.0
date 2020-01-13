Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C281397F6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMRmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 12:42:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgAMRmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 12:42:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so9522242wru.3;
        Mon, 13 Jan 2020 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VX/aiy+bNT0cIjEcj2DQ1zjepFgpqKkfM/HtHDWmDAI=;
        b=BjQqyXt5fKCdk8DNnWg0JM1q4KtfXPSfkqX89TPhIQIa7oVYbCS4gF/V/TwP1R1+gS
         qZYIqsokY4iZvxPaMjhGDc5+GQHfn0w3H61fTgu0Tmhh5cwkh0CMMrF3ES+4B0RPRqSq
         vXnq3nCwoqIuFP53+/Vamw8bRD02xnTh8WXYssuq0EFZocsZWzi9IV8M6LLv+7mJ7sWv
         ZKs0buEIuqEHO4HCOg9bNUXGZwhPUTC73iYV2hU3hSSjpVCEihEi82+2f4A0TBy8jMdR
         OQ84tpZSZVYJPzv/LJIVifkw+irOZVRw2MDXWPlGyKEI/gUEgQY55hm5F7K0TipRmn4s
         95nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VX/aiy+bNT0cIjEcj2DQ1zjepFgpqKkfM/HtHDWmDAI=;
        b=X9RCvDyvqgWbtR3sXVphDcknVT7zeBpggM6XY7ohFfc5M231wAy1ttvawgHBiPOwKy
         6xOc0DsW6D/ppZywZpfuJPYufmuhX+zYWE+q7ZBMt19+Mana2qgCSBORcp5paqwNHWV3
         gxlFB8MARox/L5Xbc88SdvFOmgyWbHPG5Rjm5F179Ou033iit6MIojfGHIiDhUauFjPS
         d7gTrL8eWAF5V8wZKHxUBIuWxINrdFDMoVHLoP5KNGHfmWyVm8IR4Q2d/sdmxTcJwPXl
         jov0fC6zPywgTli7mMXCPbl1/wjRZLDXgX3BMHU0+cv7E6p+GPXXHTe9qyNXTAU33Drg
         UK4g==
X-Gm-Message-State: APjAAAWVYrpP+YUgyB60nvnJaU832KHgv6Z3W8BWXzIFU9NJdWhZ5Qsq
        0pD6F/YQvkLenlS2wmO4K78=
X-Google-Smtp-Source: APXvYqy9/b6n+yAw3orNojEpLtY1zjet4t3YPWmZfVFJ7OEjhl7rlyML3gas7tggQmwNZmUvG16d9w==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr21067930wrc.84.1578937348999;
        Mon, 13 Jan 2020 09:42:28 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40c7:f800:a11f:9c52:9797:c64b])
        by smtp.gmail.com with ESMTPSA id x132sm573127wmg.0.2020.01.13.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 09:42:28 -0800 (PST)
Date:   Mon, 13 Jan 2020 18:42:25 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Message-ID: <20200113174225.xs3n7t3obysbsmzd@ltop.local>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
 <20200113145954.GB4458@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113145954.GB4458@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 13, 2020 at 02:59:54PM +0000, Will Deacon wrote:
> // Insert big fat comment here
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))
> 
> That apparently *requires* GCC 4.8, but I think the question is more about
> whether it's easier to stomach the funny use of _Atomic or the nested
> __builtin_choose_expr() I have here. I'm also worried about how reliable
> the _Atomic thing is, or whether it's just an artifact of how GCC happens
> to work today.

As far as I understand it, it's an artifact of how GCC works today (it
was added to support the type-generic macros in <tgmath.h>).
I also think it's also quite fragile, for example, the unqualified type
is returned if typeof's argument is an expression but not if it's a
'typename'. IOW:
	typeof(_Atomic typeof(const int))
returns 'const int', while
	typeof(({_Atomic typeof(const int) x; x; }))
returns 'int'.

-- Luc

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85D311D87E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 22:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfLLVZ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 16:25:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfLLVZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 16:25:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so4330061wrw.8;
        Thu, 12 Dec 2019 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWvSHDCJloYdqhsBLAMzfJiROysMRHLcat6wDl9FGBY=;
        b=rcZmV388GPVH/IgV+mV+nzhcX4qKkiyImB2hDSg5eKZtRroKN3Ro7o0YYlTmAI/fVK
         2+K+NpU/srYMQXean2ClLbRZvxoeK6KbzfqlbpJpML4tx/fqhCa0iffLDs4xTSj0DvWS
         qx/70QMZFdtd6mev2FY8whRJDHFNdP4WZd3Ju1KB+vrKjJwwGyarrlohrdGg4ZgScfqF
         lHsmKhGnICZoXvZApJYHVfVejpkIHcAvmgsn1aKzUz5nVHLsDh8wP3fMrrt/8cf3FV8l
         609r1mEr81a9LFMR3APQLc4dA5r7E9GaHDNuKqIghMzmX2zfYCNhpAOmt4P+CaP8nmid
         7Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWvSHDCJloYdqhsBLAMzfJiROysMRHLcat6wDl9FGBY=;
        b=N2Nzxq7pAv8jzEYfM+eQ5y/wzus9LzXJK/rDF2ib5sSr7U0Fx3jmaGfvWR8ubSXwm5
         jhl/HksqqKZtP7NbA7IjVe+fnXfnsrdOZ4g8Vim6v2QULxCXeATdFYkbopTmOIaUnOI3
         iy6cL8ipAtKjSdPoDpGNyFF1QGdHKJXq6wwzibB/Xm8cvdDNJq1AUxLfYOziXBg/bKB+
         KJaL1TKaR7KhJHmdDTZw54Fc32uDTQf6TYZLAMnDGGPflG45X1sfixmANOWXCR4fAiIP
         DEtVXzDU1u/gW4N4Pjhz+fXunsARagi6Bp7AGQ0YrvtuA9g5HoLDwWUjuybo4onjcD/I
         r5eQ==
X-Gm-Message-State: APjAAAXdr7tTrqaucG6oXemr210YxgIN4l60O9qOqThT9R46UDkmynz8
        gIxSZQMDtbHc8TeBWKuzew==
X-Google-Smtp-Source: APXvYqz9kk33zGSFPekB8PT3REMq2dR944UZWdiLl6vJytgG59kq68E8oiuhCkPTp3AuJ0yIRMy6fg==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr8793307wrq.64.1576185924421;
        Thu, 12 Dec 2019 13:25:24 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id d10sm7447378wrw.64.2019.12.12.13.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:25:23 -0800 (PST)
Date:   Fri, 13 Dec 2019 00:25:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191212212520.GA9682@avx2>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
 <20191211182401.GF31670@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211182401.GF31670@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 07:24:01PM +0100, Willy Tarreau wrote:
> On Wed, Dec 11, 2019 at 09:19:33PM +0300, Alexey Dobriyan wrote:
> > Reports are better be done by people who know what they are doing, as in
> > understand what executable stack is and what does it mean in reality.
> > 
> > > Otherwise it will just go to /dev/null with all warning about bad blocks
> > > on USB sticks and CPU core throttling under high temperature.
> > 
> > That's fine. You don't want bugreports from people who don't know what
> > is executable stack. Every security bug bounty program is flooded by
> > such people. This is why message is worded in a neutral way.
> 
> Well we definitely don't have the same experience with user reports. I
> was just suggesting, but since you apparently already have all the
> responses you needed, I'm even wondering why the warning remains.

Willy, whatever instructions for users you have in mind must be
different for different people. Developer should be told to add
"-Wl,-z,noexecstack" and more. Regular user (define "regular") should be
told to send bugreport if the program really needs executable stack
which again splits into two situations: exec stack was added knowingly
because it is some old program with lost source code or it was readded
by mistake.

"Complain to linux-kernel" is meaningless, kernel is not responsible.

What the message is even supposed to say?

It is not even pr_err.

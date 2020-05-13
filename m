Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59891D1196
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgEMLk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgEMLk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:40:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8EC061A0C;
        Wed, 13 May 2020 04:40:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so26207155wmb.4;
        Wed, 13 May 2020 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfyw3NlSdwutDK55XdZhqFB7ooI2hBWzMGPrj0wrzi8=;
        b=RcPGNTa59dxw7yNkVopnmgsI6okiD7qbnC+6mYgAav9UL342duwmwHlX1SSq8+1gkI
         E0YdmBrX/bI1NsXbZPQLJkMWU+Dc7V/ZVxZr7RhNKV+N3F1FRa1Euh4CxSBSifhOJNzS
         GalZFJdH0I2QggIJjxljrtlHPtKF7V/ngSfA+uIkrG0PFkpVKKygD1ESr+T9oruA9kmY
         yZT6O0iAivdbo4v2FwTFRCmv6QcXmyEJfrd+1m5V4IIQs+iIrgUTdFVlLkiz578LAH+j
         jH630RH3nI/ON+I+oruJbyBmSOQEQYpx9YfrdvMs9Y2Rzhu/uCXiWVxch+/eKxDyH5DC
         G6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfyw3NlSdwutDK55XdZhqFB7ooI2hBWzMGPrj0wrzi8=;
        b=rJgynEjsvxgXj3aKyPExeqr+AL45E7HrHn9tgX7AkZp+nTDCRQt3XRlHOcPIY2ea0J
         A0IZg8NJvUq1/umr49YPOK1kWPUTRFh4o1YqsdPiX+u5PGm+Vip7xpT98RnNmxTQ4Lcu
         B1szOfNbPK5eQjZiG7up6vYggftqROEAiElwejywYOZ9UgnuzYoVRRsa0XCH784WYmmw
         VKma96o0WlERrAKazxPeHO+4G+jVtN4PFUgVdirFrj9igGL2JRiwrohnceOfOsrPjj2K
         5JyW2jkSQTUOYcbI0SRxmQJntAwwYKjWN7RMbPsKStDOgl6VKajavDsSrTtN948mpssA
         Q/qg==
X-Gm-Message-State: AGi0PuY3XygU1as5hES7DqIGH2+c+VUSuuxqi+Nb/IJ3VnPxfA21lVNN
        acx0ZZfILeNVN1BiDwlaC6k=
X-Google-Smtp-Source: APiQypKMoHsnXyywqSy1TeY4yWvVIIa0HHPHYI7E8H+MRLiLq0SimZ++ZtVgQ6d2ULyTQTl5g5FmJw==
X-Received: by 2002:a1c:25c4:: with SMTP id l187mr39585522wml.89.1589370027478;
        Wed, 13 May 2020 04:40:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id g10sm25632802wrx.4.2020.05.13.04.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:40:27 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
 <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
 <20200513111340.GF21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7218089f-20df-52b3-e1d4-ac63e0215efc@gmail.com>
Date:   Wed, 13 May 2020 13:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513111340.GF21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/13/20 1:13 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:10:25PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> In reality, almost every prctl interferes with assumptions that the
>>> compiler and C library / runtime rely on.  prctl() can therefore
>>> make userspace explode in a variety ways that are likely to be hard
>>> to debug.
>>>
>>> This is not obvious to the uninitiated, so add a warning.
>>
>> Patch applied. But see my comments on patch 04. I may want to 
>> circle back on this patch later, since the wording feels a 
>> little strong to me (we simply must use prctl for some things, 
>> and not all of those things break user-space/runtime as far 
>> as I know). If you have some thoughts on softening the warning,
>> let me know.
> 
> Certainly the "if at all" can go -- this was just a suggestion
> really.

Yes. Gone.

> Maybe the whole thing is superfluous.  In C anything can screw up the
> runtime if you try hard enough.

I think it's at least worth alerting the reader to this issue.

> The background to this patch is that things like the new
> PR_PAC_RESET_KEYS and PR_SVE_SET_VL are likely to crash the program, or
> place a timebomb that will explode later when someone upgrades their
> toolchain or links with a new version of some library.  Many existing
> prctls that look equally unfriendly...
> 
> I didn't want to say nothing at all, but I didn't want to get into the
> gory details either.

(Okay.)

> Doing the digging to document the safety requirements of each prctl
> would be a lot of work, and probably an exercise in futility anyway --
> how to use a lot of prctls safely depends on the run-time environment as
> much as it does on the kernel.
> 
> 
> If you want to drop this, I'm happy to add explicit notes to just the
> new arm64 prctls instead for now.

I just softened the warning a little; see below. Explicit notes for
the new arm64 prctls would certainly be welcome.

Cheers,

Michael

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7e78fc3c1..4e2d67345 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -66,10 +66,10 @@ prctl \- operations on a process or thread
 manipulates various aspects of the behavior
 of the calling thread or process.
 .PP
-Note that careless use of
+Note that careless use of some
 .BR prctl ()
-can confuse the user-space run-time environment,
-so these operations should be used with care (if at all).
+operations can confuse the user-space run-time environment,
+so these operations should be used with care.
 .PP
 .BR prctl ()
 is called with a first argument describing what to do



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

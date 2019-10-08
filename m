Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD21CF70B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2019 12:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfJHKam (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Oct 2019 06:30:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45668 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHKam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Oct 2019 06:30:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so18693423wrm.12;
        Tue, 08 Oct 2019 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5lHuAeIrDG9VP/johzYKtAJHBG0Gx+vdNgMDdNvGZQ=;
        b=mxq2c0dMge/WK1ONqF82XxHe1rQ7f+zlZ5qJCMPruXYMOoRJ9qrjamUNh7a4vMdQnb
         9W9cDxcFW3X6yal6DHbnclcKC5ZkD4hff8iWM8RKiC2m8LIwxtquR7yNgZ1IRql057ai
         ZD/UuqPD7nN+B4Q70m3rmnfh4Jq/nELSt7QCBPvOwVecrAqDE/VZOW9sWFMLf5z8dRni
         P60yUn2Sg3dIBNbKKyZZFuiRdxdlUBfXml5Mu2GY8V7bdwYm8BGy+NVXAsm7Pt7IAnus
         7Z7tzRPlrCgGJZQw23REqSLUvE1DJsAl/H4V+iulWzXFCm8lCyA9iM5mFpjHEeRiF8Yb
         oYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5lHuAeIrDG9VP/johzYKtAJHBG0Gx+vdNgMDdNvGZQ=;
        b=eb+qEqpyOO/miTJxPcJRVTKsuf6Okmd1ksiNH8iKY+ad9471vH031W8gevvMqcXI16
         CXuTh3I1o99Q4hFsEGnFpTdiS6RMJlGRI6SmAbztD2dpP7WObb8NN7GmIWoc2g2XRxQy
         q0bZL8+azdeN2oIwmgoU0wimH7cm+Mucv3P7pfDWhhQGbQGoTExYLAWXcgoy/7qaGGKC
         x7ddeW0pIS9QjuDTGAB9bMN4LFC9rqdR5MYJzxUXRDI4tVrsSWEroO213yi5qNzfdjQH
         0+1ROS3vviLNYRbIZ4pKLVhui7y+bfTO8YDxREuZ2/Qtpluvi7M1gkb4oRZggnOGy3yn
         g66w==
X-Gm-Message-State: APjAAAX2dc3iER7RFEfa95j/sJTeZrbTzeuOZWpWyvN9clIsZ4onE8te
        Eu5ZLVa2XjU0NbJlYl6paWk=
X-Google-Smtp-Source: APXvYqx+yLmhVo59qtrHGg3BJsPgVadeghZtSHm6NsEerDLDJhE4SG+UH+62s8R4IJSQ4PaE9AvalQ==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr23331419wrc.331.1570530638027;
        Tue, 08 Oct 2019 03:30:38 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id p7sm1825629wma.34.2019.10.08.03.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:30:36 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Florian Weimer <fw@deneb.enyo.de>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Subject: Re: [REPOST][RFC][PATCH] sysctl: Remove the sysctl system call
To:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook> <87y2y271ws.fsf@mid.deneb.enyo.de>
 <87tv8pftjj.fsf_-_@x220.int.ebiederm.org> <201910031404.C30A0F16@keescook>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4c3e4883-706e-fd1b-4f4f-0653eabeb027@gmail.com>
Date:   Tue, 8 Oct 2019 12:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201910031404.C30A0F16@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/19 11:05 PM, Kees Cook wrote:
> On Thu, Oct 03, 2019 at 03:44:32PM -0500, Eric W. Biederman wrote:
>>
>> This system call has been deprecated almost since it was introduced, and none
>> of the common distributions enable it.  The only indication that I can find that
>> anyone might care is that a few of the defconfigs in the kernel enable it.  However
>> that is a small fractions of the defconfigs so I suspect it just a lack of care
>> rather than a reflection of software using the the sysctl system call.
>>
>> As there appear to be no users of the sysctl system call, remove the
>> code so that the proc filesystem can be simplified.
> 
> nitpick: line lengths near 80 characters
> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> But, yes, I would love to see this gone. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

And for the record, the manual page has since 2007 documented that 
this system call is likely to go away in the future.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

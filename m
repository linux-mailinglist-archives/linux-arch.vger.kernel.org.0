Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2781F3AD680
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 03:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhFSBen (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhFSBen (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 21:34:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F5C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 18:32:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k6so9042669pfk.12
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 18:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YwFHnlTTaMz13RCYRIL+2y1iQwoDWlR2YjoEQFcO4UM=;
        b=DSVcX9VOp0AoRrwhOjcyfdYMAXkkdNjdTqQkymnNL2WFFE+veeahA6zvyoqjiUQGEx
         RE9jwhCayyQg+t+dHq5wT5ZcUR0BD27bD0L+/U/qgwA6xhyjpujFmwG+v17rq786pzJf
         yUGZemyVbgYZQ2owVxXRhMp6YYDYGiJmry7ligWI+2Gql4bW2RyvDX9ZID1a8ZgP17Ie
         d9Xj1Pko35WaXqlqNqn/uK4KFT3iOcNyl8luouByQ/69e4WihxIyvmEVil5d/+yvMuP1
         c6jqM/f5OxxUJrD5W8VTB8OrxyOA9Vor2YDZQF0kO5y21uDyP6gl317z45E03e6xFE62
         WaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YwFHnlTTaMz13RCYRIL+2y1iQwoDWlR2YjoEQFcO4UM=;
        b=GJEP03ubzWoYccd7RWOjqVpO+ULzJaqLaZS9IftgbOM84X6dIbxtBPxlj3IPMCwoYw
         nwJlbCFD1dbxDasMD851/BZSpPPtVw6IlZnYFQRDs3gDa4gy5wwoshIGCOR2vxcWq6VB
         w34vLlkwIWDS++bC96pjnCY+KvvVtj1aIZryhmwoSwTDYPJUQs8AJ3UbyRS94ascIBSP
         XgOX/L9Za5u6M2/4fOpKwhhGQm6TIpeYNYzPxMX+ZxLJvTDAcp2qOK4gyIwOa0cOzu0X
         kX5VrEhvIYHY1WGFZH0MJZddqvzL1Os9g4Ld9GPCne6b0w9eNSvQqtkl3Pab7Rss3b1E
         iPWA==
X-Gm-Message-State: AOAM5323LB6tcWKKd4mqSXJqySDQdU7TwXebxUX/giE24PdlYoDRsVjm
        j4IX9TPUbk3RALt7JQeVQvI=
X-Google-Smtp-Source: ABdhPJwMtlZprDlyAoxBUyRJHHVl53TnITK8Gnm+SkvEU6OKpcuiyQspgUb4DGPupv+yjGOQi2UZwQ==
X-Received: by 2002:a62:834f:0:b029:2f2:9935:8fcb with SMTP id h76-20020a62834f0000b02902f299358fcbmr7863733pfe.68.1624066352036;
        Fri, 18 Jun 2021 18:32:32 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id v6sm10522032pgk.33.2021.06.18.18.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 18:32:31 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry
 points
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
 <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
 <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <2b2ba866-104c-afea-9c29-145e9d80c2d5@gmail.com>
Date:   Sat, 19 Jun 2021 13:32:23 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Am 19.06.2021 um 11:38 schrieb Linus Torvalds:
> On Fri, Jun 18, 2021 at 3:34 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> Is your patch to copy_thread() to add the extra stack frame still needed?
>
> So it's been a long time since I did any m68k assembly, but I think
> the m68k patch for the PF_IO_WORKER thread case should look something
> like the attached.
>
> Note: my only m68k work was ever on the 68008, and used the Motorola
> syntax, not the odd Sun assembler syntax, so my m68k asm skills really
> aren't good.
>
> Put another way: I'd be surprised if the attached patch actually
> works, but I think it's fairly close. I tried to add comments to
> explain the code at least a bit.

That went well:

*** FORMAT ERROR ***   FORMAT=0
Current process id is 1
BAD KERNEL TRAP: 00000000
Modules linked in:
PC: [<00002af0>] resume_userspace+0x14/0x16
SR: 2204  SP: (ptrval)  a2: 00000000
d0: 00000000    d1: 00000000    d2: 00000000    d3: 00000000
d4: 00000000    d5: 00000000    a0: 00000000    a1: 00000000
Process init (pid: 1, task=(ptrval))
Frame format=0
Stack from 0081bffc:
         19bc0000
Call Trace:
Code: 1029 0007 660c 4cdf 073e 201f 588f dfdf <4e73> 254f 03ec e308 660a 
487a ffe0 60ff 002a f6ba 598f 48e7 031e 486f 001c 61ff
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Looks like the zeroed frame was restored where we'd have expected an 
actual save frame?

I'll next try and apply your solution to IO worker threads only ...

Cheers,

	Michael

>
> Hmm?
>
>          Linus
>

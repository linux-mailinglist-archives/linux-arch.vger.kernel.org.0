Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325124663F0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 13:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354551AbhLBMvP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 07:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346778AbhLBMvP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 07:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638449272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KE2G0AMF/4qelfuYaRJl7lFx9i78+mXpky9NUQaLvE=;
        b=brEe10ASWTu+I1lTRIeXqDsskeTH8vgWob2NUijaoopIov0orOEn/rayrwQ7EAtXvZCU0F
        zt615VD1RQlKVepHt4pXrCLiCXB7mwj2GFJOYlgcOfDaEY61kkFvmrqUQaLj1OHQb7j4Qy
        MNlvJPLe51NFp4ralM5UX7B2CQRFCdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-FemBUM_aP9ORXTOFDF7ZiA-1; Thu, 02 Dec 2021 07:47:51 -0500
X-MC-Unique: FemBUM_aP9ORXTOFDF7ZiA-1
Received: by mail-wr1-f69.google.com with SMTP id r2-20020adfe682000000b00198af042b0dso5016363wrm.23
        for <linux-arch@vger.kernel.org>; Thu, 02 Dec 2021 04:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/KE2G0AMF/4qelfuYaRJl7lFx9i78+mXpky9NUQaLvE=;
        b=NjDBcoLwewZ0JPe+MUt0KqZ3bzB1CTubcbLlYrw9WRx2pdp04BjzDGz08emE+Ai8VP
         ksT0Mck4eJNMrN9S+ZPmUvuRiVMZrccKzHHPG4Y3ZwT0Azmyr7HYFyMoRh/cT/BAhhIt
         bWAo1ZDpwTvYjotKnNgKEyffbrdnP5YYhncaowvQYwRSiJ2LmDa0bytohO7cRxHQQzVG
         peDurKJqejU5u152DmbleeQhmrlw+JM7tz1skVO7LBN+VBeO8HZVs2WRRMi7V0huiF22
         MhgUAK4G70Em/JpUHjM4lquvdm3miccdX/SnbXrBVEDYVmCFzfak3O3je2sLdwWM7NCV
         B1VA==
X-Gm-Message-State: AOAM532NhYSbsdG1prO5/6zrbpzt+E+hKt2uaEoiqHkrHUQguwbmK4pV
        aYC/F4438BPylcsesPanED2wCfwZDWvaTocG/paS+E3OyZ1BFgaCB58yk6wZtovdhYCQd4RBVog
        AXwTeZaJOgTHe2qjAYiPWZA==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr14069716wrq.85.1638449270583;
        Thu, 02 Dec 2021 04:47:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqhQFbTGgCi88qT+eGiKRbZJMiOQNTZSY0Ec9iA1YtsqGsT5YMm4zCKF/77tnNlZNp56fdSw==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr14069698wrq.85.1638449270341;
        Thu, 02 Dec 2021 04:47:50 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id m21sm2507081wrb.2.2021.12.02.04.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 04:47:49 -0800 (PST)
Message-ID: <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
Date:   Thu, 2 Dec 2021 13:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     fei luo <morphyluo@gmail.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
References: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFD] clear virtual machine memory when virtual machine is turned
 off
In-Reply-To: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.12.21 11:19, fei luo wrote:
> Hi,
> 
> When running the kvm virtual machine in Linux, because the virtual
> 
> machine may contain sensitive data, the user may not want these
> 
> data to remain in the memory after the virtual machine is turned off.
> 

Hi,

yes, just like if the VM is running.

> 
> Although this part of memory will be cleared before being reused by
> 
> user-mode programs , But the sensitive data staying in the memory
> 
> for a long time will undoubtedly increase the risk of information leakage,
> 
> so I wonder whether it is possible to add a flag (like MAP_UNMAPZERO)
> 
> to the mmap(2) system call to indicate that the mapped memory needs
> 
> to be cleared zero when unmap called or when the program exits.
> 

it's not immediately clear to me why data of user space program #1
should be more important than data of user space program #2 and why the
program should make that decision.

> 
> Of course, the page clear operation not only occurs when unmap called
> 
> or program exits, but also need to consider scenes such as page migration,
> 
> swap, balloon etc.

What about page migration (who clears the old memory location?),
swapping (who clears the swap space, also considering zram?), writeback
(who clears file storage)? Also, as you indicate, MADV_DONTNEED,
MADV_FREE, FALLOC_FL_PUNCH_HOLE would need care ...

To disable swapping you can use mlock(). To handle file storage ...
don't use files. You'd still have to handle any cases where physical
memory locations might be freed and land in the buddy, and for that we
do have ...

> 
> 
> When reusing the page that has been cleared, there is no need to clear it
> 
> again, which also speeds up the memory allocation of user-mode programs.
> 
> 
> Is this feature feasible?

"init_on_free=1" for the system as a whole, which might sounds like what
might tackle part of your use case.

-- 
Thanks,

David / dhildenb


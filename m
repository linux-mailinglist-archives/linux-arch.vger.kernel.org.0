Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B84E3EDE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 13:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiCVM52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiCVM50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 08:57:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19275BE52;
        Tue, 22 Mar 2022 05:55:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KNBLF5S7Dz1GClp;
        Tue, 22 Mar 2022 20:55:49 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 20:55:56 +0800
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:55:56 +0800
Subject: Re: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20220318071130.163942-1-chenjiahao16@huawei.com>
 <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
Message-ID: <88ff36b3-558b-9c3f-f21d-5ef05b3227c5@huawei.com>
Date:   Tue, 22 Mar 2022 20:55:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 2022/3/18 15:44, Arnd Bergmann 写道:
> On Fri, Mar 18, 2022 at 8:11 AM Chen Jiahao <chenjiahao16@huawei.com> wrote:
>> In __access_ok, TASK_SIZE_MAX is used to check if a memory access
>> is in user address space, but some cases may get omitted in compat
>> mode.
>>
>> For example, a 32-bit testcase calling pread64(fd, buf, -1, 1)
>> and running in x86-64 kernel, the obviously illegal size "-1" will
>> get ignored by __access_ok. Since from the kernel point of view,
>> 32-bit userspace 0xffffffff is within the limit of 64-bit
>> TASK_SIZE_MAX.
>>
>> Replacing the limit TASK_SIZE_MAX with TASK_SIZE in __access_ok
>> will fix the problem above.
> I don't see what problem this fixes, the choice of TASK_SIZE_MAX in
> __access_ok() is intentional, as this means we can use a compile-time
> constant as the limit, which produces better code.
>
> Any user pointer between COMPAT_TASK_SIZE and TASK_SIZE_MAX is
> not accessible by a user process but will not let user space access
> any kernel data either, which is the point of the check.
>
> In your example of using '-1' as the pointer, access_ok() returns true,
> so the kernel can go on to perform an unchecked __get_user() on
> __put_user() on 0xffffffffull, which causes page fault that is intercepted
> by the ex_table fixup.
>
> This should not result in any user visible difference, in both cases
> user process will see a -EFAULT return code from its system call.
> Are you able to come up with a test case that shows an observable
> difference in behavior?
>
>        Arnd
>
> .

Actually, this patch do comes from a testcase failure, the code is 
pasted below:

#define TMPFILE "__1234567890"
#define BUF_SIZE    1024

int main()
{
     char buf[BUF_SIZE] = {0};
     int fd;
     int ret;
     int err;

     fd = open(TMPFILE, O_CREAT | O_RDWR);
     if(-1 == fd)
     {
         perror("open");
         return 1;
     }

     ret = pread64(fd, buf, -1, 1);
     if((-1 == ret) && (EFAULT == errno))
     {
         close(fd);
         unlink(TMPFILE);
         printf("PASS\n");
         return 0;
     }
     err = errno;
     perror("pread64");
     printf("err = %d\n", err);
     close(fd);
     unlink(TMPFILE);
     printf("FAIL\n");

     return 1;
  }

The expected result is:

PASS

but the result of 32-bit testcase running in x86-64 kernel with compat 
mode is:

pread64: Success
err = 0
FAIL


In my explanation, pread64 is called with count '0xffffffffull' and 
offset '1', which might still not trigger

page fault in 64-bit kernel.


This patch uses TASK_SIZE as the addr_limit to performance a stricter 
address check and intercepts

the illegal pointer address from 32-bit userspace at a very early time. 
Which is roughly the same

address limit check as __access_ok in arch/ia64.


This is why this fixes my testcase failure above, or have I missed 
anything else?


Jiahao


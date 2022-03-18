Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619574DD561
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 08:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiCRHpu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiCRHpo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 03:45:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F731F42D2;
        Fri, 18 Mar 2022 00:44:25 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mbj3e-1o66GH3f4A-00dDLd; Fri, 18 Mar 2022 08:44:23 +0100
Received: by mail-wr1-f42.google.com with SMTP id x15so10537017wru.13;
        Fri, 18 Mar 2022 00:44:23 -0700 (PDT)
X-Gm-Message-State: AOAM531FTlH57ouvnkxx9jRG6mZfwgsSMPvRmeDZAIjdTb0ixiecWBdO
        iVRx68m9YlLw62eogSi/YprB71p9jsSQfMaTnRc=
X-Google-Smtp-Source: ABdhPJzIXhZOJi6NWdZqeu15CdJ5JFHp9oqnOe609rHntiPX/cWxExSEoXOsOalxM26KcvxA30q//5tG2XN3EpRswjE=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr6942693wrq.192.1647589463306; Fri, 18
 Mar 2022 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220318071130.163942-1-chenjiahao16@huawei.com>
In-Reply-To: <20220318071130.163942-1-chenjiahao16@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Mar 2022 08:44:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
Message-ID: <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
Subject: Re: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xeXYH6qbgvt7UHc7zDtYFQsBnW61JIFhVjyTjlYhP91VSEkQz49
 0Z6vAIYbrA2pEGDpoBZ70w5BJm3sRMSx6BUqn2aqTsWfOu4A2JagdEcssWF0FAv7iJrTMFZ
 u7B/I7ALAVCuhwe2BFnLqoT5XIUenK6PcZZwnHu3EzWanFOKEjI0h/VivNNgEB9sJ0GWRws
 eeZ2WRlF8xpSINOS9cK9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0P+KlHjPBMg=:rHJzmBHGlNG+M2D+4oveca
 fkhqpwbBsOG1Am8s1I04Uba7/FMpmGRPd4LQK/mU5giubn919sik/YYf34X2I8ERQY9Hthzyg
 1Qwckv4Cfaes3aWZruuMEuz+8cpf7ZCuAS9cDZs+N3ZkX34OVhwmHT34qZXz499ODx3AnJbkr
 9PHykrskRoBzdE3nGz8T70SmxYd9stp0hWi94AkJZm992V0F417q3lt3OPlgzg2c7hLnc+Oca
 eIMVEFmXmrtzDyjRr1kvLy76XjOlCI4PfapxjKvF1t3s5NcBWqD12psaIbwXyhMcD9OWaQlbu
 zci7UdgyE/W4Ia30g7kXNmf/aMEVb5xQrsYGkyj5DZyK3gG9hyW0lQBEqn6RYSkPjS0ZqYJwv
 WXFg4ANP0+c+pLGvh4bK89VxOTfgd0Ij/jg5xj7R5+w5jtQTrbvzFOI6GZKZqKHQAfBGz4IxZ
 i5cRK65bL5jR80H4cegMEC3W3Zn5PucfA/5+2YVclRPaWDl7fOr4T4ir2pMYaPLZmrO2UeSP6
 PEJ13+uPLtWYBQiyKJp8aanVGAjLhXMik6QRkQM/s1X5mQMK14qDU8DDay2yKgsXb/wnkpY+x
 hzhGDTcn4kNw0AOeFIN3qtrq26yTI6L4/QHTgJRw7vm9X5HUUEBouZcFfSmO2f7ltpQSQ3f1r
 JNuaudGZJVXzCAD7SxL/IsQLrxUDxOOdjA/MzJ6UVQKVnlzVL26uNC4jpmcKrntW6lT1XmNUH
 LG+kOU6gkEc2stU35rgDD8KiNascE1WGszQhWkiuZZMQ6SmZMbkZDblhVt7HZlpsUxXlbMecc
 rBprlwCSN5g2bDZbnXegLvS3igBgIddgEWD7uQ02I/Y8QcOBlU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 18, 2022 at 8:11 AM Chen Jiahao <chenjiahao16@huawei.com> wrote:
>
> In __access_ok, TASK_SIZE_MAX is used to check if a memory access
> is in user address space, but some cases may get omitted in compat
> mode.
>
> For example, a 32-bit testcase calling pread64(fd, buf, -1, 1)
> and running in x86-64 kernel, the obviously illegal size "-1" will
> get ignored by __access_ok. Since from the kernel point of view,
> 32-bit userspace 0xffffffff is within the limit of 64-bit
> TASK_SIZE_MAX.
>
> Replacing the limit TASK_SIZE_MAX with TASK_SIZE in __access_ok
> will fix the problem above.

I don't see what problem this fixes, the choice of TASK_SIZE_MAX in
__access_ok() is intentional, as this means we can use a compile-time
constant as the limit, which produces better code.

Any user pointer between COMPAT_TASK_SIZE and TASK_SIZE_MAX is
not accessible by a user process but will not let user space access
any kernel data either, which is the point of the check.

In your example of using '-1' as the pointer, access_ok() returns true,
so the kernel can go on to perform an unchecked __get_user() on
__put_user() on 0xffffffffull, which causes page fault that is intercepted
by the ex_table fixup.

This should not result in any user visible difference, in both cases
user process will see a -EFAULT return code from its system call.
Are you able to come up with a test case that shows an observable
difference in behavior?

      Arnd

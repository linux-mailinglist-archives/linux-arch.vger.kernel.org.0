Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025F7902B7
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjIAUFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjIAUFq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 16:05:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB810FB;
        Fri,  1 Sep 2023 13:05:43 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381JasMx010636;
        Fri, 1 Sep 2023 20:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=XkyM1HQkpUVlSXk7Gq95YDhU1bCyir2wQkYtrEf1+JM=;
 b=S1HnSm8milz3DfyV8tFwzFuE2EBdDxpALLIcQ/EDnoyvLVbSvY3LDjxujJfe/O5u4Shb
 pDxMlZrjyK0Bypu2zn5qaXwgnjijcz1ie8pBM60UJzlFRoXKyDzNPujgCD1mu+mM0kAF
 JYC9UbhZOcQ5CZW8ZrvcScbDkZtYK6lTS3rVI5QpguwlXGXhFgY75iszfOsmN+z5efdd
 zGGhOqrny6biTzmKCXkdaTi1wHuGRZIgQHeAxxLUAIBAJTmoD3co5lcSXbGiVTobmAKk
 srAKhpQy16Uxfthj6DA+y05SIL1YeCUm8ssGK4o0vf3PUdWp5tLm+D1z+/8bmtZPUMLW UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sup2ugyh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:05:23 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381K0PnA014872;
        Fri, 1 Sep 2023 20:05:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sup2ugygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:05:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381Igmr5004911;
        Fri, 1 Sep 2023 20:05:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqtfvb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:05:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381K5JRQ63766918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 20:05:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDEA32004F;
        Fri,  1 Sep 2023 20:05:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E56852004B;
        Fri,  1 Sep 2023 20:05:18 +0000 (GMT)
Received: from osiris (unknown [9.171.55.36])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Sep 2023 20:05:18 +0000 (GMT)
Date:   Fri, 1 Sep 2023 22:05:17 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
Message-ID: <20230901200517.8742-A-hca@linux.ibm.com>
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
 <20230608202628.837772-2-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608202628.837772-2-aleksandr.mikhalitsyn@canonical.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 88DkXOkw5sUQvxaIYsQazRgmpzoByUCt
X-Proofpoint-ORIG-GUID: oTBpevmAfRXlaY89-fC4VH12UFfCW9w6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010183
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wrote:
> Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
> but it contains pidfd instead of plain pid, which allows programmers not
> to care about PID reuse problem.
> 
> We mask SO_PASSPIDFD feature if CONFIG_UNIX is not builtin because
> it depends on a pidfd_prepare() API which is not exported to the kernel
> modules.
> 
> Idea comes from UAPI kernel group:
> https://uapi-group.org/kernel-features/
> 
> Big thanks to Christian Brauner and Lennart Poettering for productive
> discussions about this.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Tested-by: Luca Boccassi <bluca@debian.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 ++
>  arch/mips/include/uapi/asm/socket.h     |  2 ++
>  arch/parisc/include/uapi/asm/socket.h   |  2 ++
>  arch/sparc/include/uapi/asm/socket.h    |  2 ++
>  include/linux/net.h                     |  1 +
>  include/linux/socket.h                  |  1 +
>  include/net/scm.h                       | 39 +++++++++++++++++++++++--
>  include/uapi/asm-generic/socket.h       |  2 ++
>  net/core/sock.c                         | 11 +++++++
>  net/mptcp/sockopt.c                     |  1 +
>  net/unix/af_unix.c                      | 18 ++++++++----
>  tools/include/uapi/asm-generic/socket.h |  2 ++
>  12 files changed, 76 insertions(+), 7 deletions(-)
...
> +static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> +{
> +	struct file *pidfd_file = NULL;
> +	int pidfd;
> +
> +	/*
> +	 * put_cmsg() doesn't return an error if CMSG is truncated,
> +	 * that's why we need to opencode these checks here.
> +	 */
> +	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
> +	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
> +		msg->msg_flags |= MSG_CTRUNC;
> +		return;
> +	}

This does not work for compat tasks since the size of struct cmsghdr (aka
struct compat_cmsghdr) is differently. If the check from put_cmsg() is
open-coded here, then also a different check for compat tasks needs to be
added.

Discovered this because I was wondering why strace compat tests fail; it
seems because of this.

See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c

For compat tasks recvmsg() returns with msg_flags=MSG_CTRUNC since the
above code expects a larger buffer than is necessary.

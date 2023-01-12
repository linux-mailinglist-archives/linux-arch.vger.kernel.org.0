Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB716680D6
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 21:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbjALUAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbjALT7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 14:59:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265403882;
        Thu, 12 Jan 2023 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4aFpXbTN+2q/sQWoIhQXRuBIzQdX59WKAp/kjFjx5nI=; b=EXFl9MaMND0FkMicNKlfspElVB
        huiMp2O7+Fvk4uwlSWk2b77yH7f4axNULDLOvrmgF2stY4NTNGRJ25ZSpXd9goBg/VkJdWWaXP+Gr
        Of7rP+CRWQSMlE+dfMMiwNu6KPhGmNs+/4kt/1x2eSDBQGLkb7G0JxjG3bjP6egK+5K3BYl2NDXSI
        EWmjrlA8t5XxbT818dX7+Vt3AqBBUhu093wyPACd2zLypjFT7H2JDrsNcfcD/XHM7W3wj7ZN5Nh6N
        zG0q4ipZCd55Lg30zpCT0GHj8smeXMq8oSjlRgA598BxbO+Tnb+HSoRDuOLJvyhSzEi1pRgNhbbQw
        1dyt/7Iw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pG3hL-0045pn-36;
        Thu, 12 Jan 2023 19:57:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04574303466;
        Thu, 12 Jan 2023 20:57:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4EBB62CD066D0; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.782536366@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 20:43:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
        Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org,
        paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 40/51] cpuidle,powerdomain: Remove trace_.*_rcuidle()
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

OMAP was the one and only user.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-omap2/powerdomain.c |   10 +++++-----
 drivers/base/power/runtime.c      |   24 ++++++++++++------------
 2 files changed, 17 insertions(+), 17 deletions(-)

--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -187,9 +187,9 @@ static int _pwrdm_state_switch(struct po
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
 				       ((next & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
-			trace_power_domain_target_rcuidle(pwrdm->name,
-							  trace_state,
-							  raw_smp_processor_id());
+			trace_power_domain_target(pwrdm->name,
+						  trace_state,
+						  raw_smp_processor_id());
 		}
 		break;
 	default:
@@ -541,8 +541,8 @@ int pwrdm_set_next_pwrst(struct powerdom
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
-		trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
-						  raw_smp_processor_id());
+		trace_power_domain_target(pwrdm->name, pwrst,
+					  raw_smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -442,7 +442,7 @@ static int rpm_idle(struct device *dev,
 	int (*callback)(struct device *);
 	int retval;
 
-	trace_rpm_idle_rcuidle(dev, rpmflags);
+	trace_rpm_idle(dev, rpmflags);
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		;	/* Conditions are wrong. */
@@ -481,7 +481,7 @@ static int rpm_idle(struct device *dev,
 			dev->power.request_pending = true;
 			queue_work(pm_wq, &dev->power.work);
 		}
-		trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
+		trace_rpm_return_int(dev, _THIS_IP_, 0);
 		return 0;
 	}
 
@@ -493,7 +493,7 @@ static int rpm_idle(struct device *dev,
 	wake_up_all(&dev->power.wait_queue);
 
  out:
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
@@ -557,7 +557,7 @@ static int rpm_suspend(struct device *de
 	struct device *parent = NULL;
 	int retval;
 
-	trace_rpm_suspend_rcuidle(dev, rpmflags);
+	trace_rpm_suspend(dev, rpmflags);
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
@@ -708,7 +708,7 @@ static int rpm_suspend(struct device *de
 	}
 
  out:
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 
 	return retval;
 
@@ -760,7 +760,7 @@ static int rpm_resume(struct device *dev
 	struct device *parent = NULL;
 	int retval = 0;
 
-	trace_rpm_resume_rcuidle(dev, rpmflags);
+	trace_rpm_resume(dev, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error) {
@@ -925,7 +925,7 @@ static int rpm_resume(struct device *dev
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 
 	return retval;
 }
@@ -1081,7 +1081,7 @@ int __pm_runtime_idle(struct device *dev
 		if (retval < 0) {
 			return retval;
 		} else if (retval > 0) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+			trace_rpm_usage(dev, rpmflags);
 			return 0;
 		}
 	}
@@ -1119,7 +1119,7 @@ int __pm_runtime_suspend(struct device *
 		if (retval < 0) {
 			return retval;
 		} else if (retval > 0) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+			trace_rpm_usage(dev, rpmflags);
 			return 0;
 		}
 	}
@@ -1202,7 +1202,7 @@ int pm_runtime_get_if_active(struct devi
 	} else {
 		retval = atomic_inc_not_zero(&dev->power.usage_count);
 	}
-	trace_rpm_usage_rcuidle(dev, 0);
+	trace_rpm_usage(dev, 0);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
@@ -1566,7 +1566,7 @@ void pm_runtime_allow(struct device *dev
 	if (ret == 0)
 		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
 	else if (ret > 0)
-		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
+		trace_rpm_usage(dev, RPM_AUTO | RPM_ASYNC);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
@@ -1635,7 +1635,7 @@ static void update_autosuspend(struct de
 			atomic_inc(&dev->power.usage_count);
 			rpm_resume(dev, 0);
 		} else {
-			trace_rpm_usage_rcuidle(dev, 0);
+			trace_rpm_usage(dev, 0);
 		}
 	}
 


